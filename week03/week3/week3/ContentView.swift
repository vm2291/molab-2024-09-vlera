import SwiftUI

extension Color {
    static let navyBlue = Color(red: 0.0, green: 0.0, blue: 0.100)
}

struct ContentView: View {
    let moonColors: [Color] = [.yellow, .orange, .brown, .purple, .red.opacity(0.5), .gray, .green]
    

    @State private var currentMoonColor: Color = .yellow

    var body: some View {
        ZStack {
            Color.navyBlue
                .edgesIgnoringSafeArea(.all)
            
            cloudShape()
                .offset(x: -40, y: 0)
            
            moonShape()
                .offset(x: 100, y: -100)
            

            Button(action: {
                currentMoonColor = moonColors.randomElement() ?? .yellow
            }) {
                Text("Change Moon Color")
                    .font(.title)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
            }
            
            .offset(y: 300)
        }
    }
    
    func cloudShape() -> some View {
        Group {
            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: 100, height: 100)
            Circle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 120, height: 120)
                .offset(x: 30, y: 20)
            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: 90, height: 90)
                .offset(x: -30, y: 30)
            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: 110, height: 110)
                .offset(x: 70, y: 20)
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: 80, height: 80)
                .offset(x: 10, y: 40)
        }
    }
    
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


