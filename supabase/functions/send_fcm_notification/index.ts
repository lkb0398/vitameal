// 🤍 변경 후 적용 명령어 : supabase functions deploy send_fcm_notification --no-verify-jwt

import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { SignJWT, importPKCS8 } from "https://esm.sh/jose@5.2.4";

// ==================== Supabase Client (Service Role) ====================
const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

// ==================== FCM OAuth Access Token ====================
async function getAccessToken(): Promise<string> {
  const clientEmail = Deno.env.get("FCM_CLIENT_EMAIL")!;
  const privateKeyRaw = Deno.env.get("FCM_PRIVATE_KEY")!;
  const privateKey = privateKeyRaw.replace(/\\n/g, "\n");

  const now = Math.floor(Date.now() / 1000);

  const key = await importPKCS8(privateKey, "RS256");

  const jwt = await new SignJWT({
    scope: "https://www.googleapis.com/auth/firebase.messaging",
  })
    .setProtectedHeader({ alg: "RS256" })
    .setIssuer(clientEmail)
    .setAudience("https://oauth2.googleapis.com/token")
    .setIssuedAt(now)
    .setExpirationTime(now + 3600)
    .sign(key);

  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  const data = await res.json();

  if (!data.access_token) {
    console.error("OAuth token error:", data);
    throw new Error("Failed to get access token");
  }

  return data.access_token;
}

// ==================== Main Handler (Cron Entry) ====================
serve(async () => {
  try {
    console.log("🚀 function start");

    const nowUtc = new Date();

    // 1. 알림 보낼 목록 조회 (next_fire_at 기준 제거)
    const { data: notis, error } = await supabase
      .from("notifications")
      .select("*")
      .eq("is_enabled", true);

    if (error) {
      console.error("❌ notifications query error", error);
      throw error;
    }

    console.log("notis length:", notis?.length ?? 0);

    if (!notis || notis.length === 0) {
      return new Response("No notifications", { status: 200 });
    }

    const accessToken = await getAccessToken();
    const projectId = Deno.env.get("FCM_PROJECT_ID")!;

    // 2. 알림 처리 
    for (const noti of notis) {
      // 2-1. 현재 시간 (기본 UTC > timezone 기준 계산)
      const nowLocal = new Date(
        nowUtc.toLocaleString("en-US", { timeZone: noti.timezone }),
      );

      // 2-2. 사용자가 설정한 알림 시간
      const [hour, minute] = noti.time.split(":").map(Number);
      const scheduled = new Date(nowLocal);
      scheduled.setHours(hour, minute, 0, 0);

      // 2-3. 두 개 비교하여 지금 울릴 타이밍인지 판단
      const diff = scheduled.getTime() - nowLocal.getTime();
      if (diff < 0 || diff > 30 * 1000) continue;
      console.log("🔔 SEND:", noti.noti_id, noti.label);

      // 2-4. 사용자 FCM 토큰 조회
      const { data: tokens } = await supabase
        .from("fcm_tokens")
        .select("fcm_token")
        .eq("user_id", noti.user_id);

      if (!tokens || tokens.length === 0) continue;

      // 2-5. FCM 발송
      for (const t of tokens) {
        const res = await fetch(
          `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
          {
            method: "POST",
            headers: {
              Authorization: `Bearer ${accessToken}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              message: {
                token: t.fcm_token,
                // 🤍 시스템 알림 커스텀
                notification: {
                  title: `vitameal`,
                  body: noti.label,
                },

                // 앱 로직용 데이터 > 로컬 알림 표시에서 커스텀 예정
                data: {
                  type: "alarm",
                  alarm_id: noti.noti_id,
                  label: noti.label,
                  time: noti.time,
                },

                android: {
                  priority: "high",
                  notification: {
                    channel_id: "vitameal_alarm",
                    sound: "default",
                  },
                },
                
                apns: {
                  payload: {
                    aps: {
                      sound: "default",
                    },
                  },
                },
              },
            }),
          },
        );

        if (!res.ok) {
          console.error(
            "FCM send failed:",
            t.fcm_token,
            await res.text(),
          );
        }
      }
    }

    return new Response("OK", { status: 200 });
  } catch (e) {
    console.error("🔥 FUNCTION ERROR", e);
    return new Response(
      JSON.stringify({ error: String(e) }),
      { status: 500 },
    );
  }
});