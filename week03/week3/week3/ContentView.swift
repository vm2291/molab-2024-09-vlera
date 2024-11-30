import SwiftUI

extension Color {
    static let navyBlue = Color(red: 0.0, green: 0.0, blue: 0.1)
}

struct ContentView: View {
    let moonColors: [Color] = [.yellow, .orange, .brown, .purple, .red.opacity(0.89), .gray, .green]
    let starColors: [Color] = [.white.opacity(0.9), .white.opacity(0.89), .white.opacity(0.89)]
    let starEmoji = "⭐️"

    @State private var currentMoonColor: Color = .yellow

    var body: some View {
        ZStack {
            
            Color.navyBlue
                .ignoresSafeArea()

            // Randomized stars
            ForEach(0..<15, id: \.self) { _ in
                starEmojiView()
                    .offset(
                        x: CGFloat.random(in: -200...200),
                        y: CGFloat.random(in: -400...400)
                    )
            }

            // The moon
            moonShape()
                .offset(x: 100, y: -100)

            // Button to change moon color
            Button(action: {
                currentMoonColor = moonColors.randomElement() ?? .yellow
            }) {
                Text("Change Moon Color")
                    .font(.title)
                    .padding()
                    .background(Color.white.opacity(0.99))
                    .cornerRadius(10)
            }
            .offset(y: 300)
        }
    }

    // Star emoji view
    func starEmojiView() -> some View {
        Text(starEmoji)
            .font(.system(size: CGFloat.random(in: 30...60)))
            .foregroundColor(starColors.randomElement() ?? .white)
            .rotationEffect(.degrees(Double.random(in: 0...360)))
    }

    // Moon shape
    func moonShape() -> some View {
        ZStack {
            Circle()
                .fill(currentMoonColor)
                .frame(width: 100, height: 100)
            Circle()
                .fill(Color.navyBlue)
                .frame(width: 80, height: 80)
                .offset(x: 30, y: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

