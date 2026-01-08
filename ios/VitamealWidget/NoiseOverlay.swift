import SwiftUI

/// 간단한 노이즈 텍스처 오버레이 (위젯용)
struct NoiseOverlay: View {
    var opacity: CGFloat = 0.12

    var body: some View {
        Canvas { context, size in
            // 랜덤 점들을 뿌려 노이즈 느낌을 만듦
            let count = Int((size.width * size.height) / 18) // 밀도 조절 포인트
            for _ in 0..<count {
                let x = CGFloat.random(in: 0...size.width)
                let y = CGFloat.random(in: 0...size.height)
                let r = CGFloat.random(in: 0.4...1.2)

                let alpha = Double.random(in: 0.06...0.18)
                context.fill(
                    Path(ellipseIn: CGRect(x: x, y: y, width: r, height: r)),
                    with: .color(.white.opacity(alpha))
                )
            }
        }
        .allowsHitTesting(false)
        .blendMode(.overlay)
        .opacity(opacity)
    }
}
