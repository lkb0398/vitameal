// 🤍 변경 후 적용 명령어 : supabase functions deploy search-eats

import { serve } from "https://deno.land/std/http/server.ts";

// ================= 태그 - 키워드 변환 =================
const tagIdMap: Record<number, string> = {
  1: "다이어트식",
  2: "고단백식",
  3: "저탄수화물식",
  4: "키토제닉식",
  5: "당질제한식",
  6: "저염식",
  7: "저당식",
  8: "저콜레스테롤식",
  9: "당뇨식",
  10: "저푸린식",
  11: "저요오드식",
  12: "저잔사식",
  13: "글루텐프리식",
  14: "포드맵",
  15: "디톡스식",
  16: "유동식",
  17: "비건식",
  18: "페스코",
  19: "지중해식",
  20: "대시",
};

const tagKeywordMap: Record<string, string[]> = {
  "다이어트식": ["salad", "poke", "healthy food", "low calorie"], 
  "고단백식": ["chicken breast", "protein", "high protein"], 
  "저탄수화물식": ["low carb", "keto"], 
  "키토제닉식": ["keto", "low carb"], 
  "당질제한식": ["low carb", "keto", "sugar free"], 
  "저염식": ["healthy food", "salad"], 
  "저당식": ["sugar free", "low sugar"], 
  "저콜레스테롤식": ["vegan", "plant based"], 
  "당뇨식": ["low sugar", "keto"], 
  "저푸린식": ["vegan", "vegetarian"], 
  "저요오드식": ["vegan"], 
  "저잔사식": ["porridge", "soup"], 
  "글루텐프리식": ["gluten free"], 
  "포드맵": ["low fodmap", "gluten free"], 
  "디톡스식": ["juice", "smoothie"], 
  "유동식": ["porridge", "soup", "congee"], 
  "비건식": ["vegan", "plant based"], 
  "페스코": ["seafood", "poke", "fish"], 
  "지중해식": ["mediterranean", "greek"], 
  "대시": ["healthy food", "salad"],
};

// ================= 거리 계산 =================
function getDistance(lat1: number, lng1: number, lat2: number, lng2: number) {
  const R = 6371;
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLng = (lng2 - lng1) * Math.PI / 180;

  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(lat1 * Math.PI / 180) *
      Math.cos(lat2 * Math.PI / 180) *
      Math.sin(dLng / 2) *
      Math.sin(dLng / 2);

  return R * (2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)));
}

// ================= 건강 점수 (태그 적합도) =================
function getHealthScore(name: string, rating: number, keywords: string[]) {
  const lower = name.toLowerCase();

  let keywordScore = 0;
  for (const k of keywords) {
    if (lower.includes(k.toLowerCase())) {
      keywordScore += 3;
    }
  }

  return keywordScore + (rating ?? 0) * 2;
}

// ================= MAIN =================
serve(async (req) => {
  try {
    const body = await req.json().catch(() => null);

    const { lat, lng, tagId } = body || {};

    if (!lat || !lng || !tagId) {
      return new Response(
        JSON.stringify({ error: "Missing params" }),
        { status: 400 }
      );
    }

    const tag = tagIdMap[tagId];
    const keywords = tagKeywordMap[tag] ?? ["healthy"];
    const apiKey = Deno.env.get("GOOGLE_PLACES_API_KEY");

    const url =
      `https://maps.googleapis.com/maps/api/place/nearbysearch/json` +
      `?location=${lat},${lng}` +
      `&radius=1500` +
      `&type=restaurant` +
      `&keyword=${keywords.join("|")}` +
      `&key=${apiKey}`;

    const res = await fetch(url);
    const data = await res.json();

    let results = data.results ?? [];

    // 가공
    results = results.map((r: any) => {
      const lat2 = r.geometry?.location?.lat ?? 0;
      const lng2 = r.geometry?.location?.lng ?? 0;

      const distance = getDistance(lat, lng, lat2, lng2);
      const score = getHealthScore(r.name ?? "", r.rating ?? 0, keywords);

      return {
        name: r.name ?? "",
        lat: lat2,
        lng: lng2,
        rating: r.rating ?? 0,
        distance,
        score,
      };
    });

    // 정렬
    results.sort((a: any, b: any) => {
      if (b.score !== a.score) return b.score - a.score;
      return a.distance - b.distance;
    });

    return new Response(
      JSON.stringify({ results }),
      { headers: { "Content-Type": "application/json" } }
    );

  } catch (e) {
    return new Response(
      JSON.stringify({
        error: e.message,
      }),
      { status: 500 }
    );
  }
});