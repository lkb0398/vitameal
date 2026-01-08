import SwiftUI

/// 홈 화면 위젯에서 "유리"처럼 보이게 만드는 배경
/// - Material 대신: 그라디언트 + 노이즈 + 스트로크 조합
struct GlassBackground: View {
    var cornerRadius: CGFloat = 18

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            // 1) 베이스: 아주 옅은 반투명 틴트
            .fill(Color.white.opacity(0.10))
            // 2) 상단 하이라이트 그라디언트(빛 반사 느낌)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: Color.white.opacity(0.22), location: 0.0),
                                .init(color: Color.white.opacity(0.10), location: 0.35),
                                .init(color: Color.white.opacity(0.06), location: 1.0),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blendMode(.screen)
            )
            // 3) 미세 노이즈(질감)
            .overlay(
                NoiseOverlay(opacity: 0.10)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            )
            // 4) 얇은 외곽 스트로크(유리 테두리)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.18), lineWidth: 0.8)
            )
            // 5) 내부 하이라이트(위쪽만 살짝)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.28),
                                Color.white.opacity(0.00)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1.0
                    )
                    .padding(0.5)
                    .opacity(0.9)
            )
            // 6) 약한 그림자(떠 있는 카드 느낌)
            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 6)
    }
}
