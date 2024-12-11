import SwiftUI

struct NatureAudiosView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Nature Sounds")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .padding()

                NavigationLink(destination: SoundView(title: "Rain", audioFile: "rain.mp3", backgroundImage: "rain")) {
                    CategoryView(title: "Rain")
                }

                NavigationLink(destination: SoundView(title: "Ocean Waves", audioFile: "ocean.mp3", backgroundImage: "ocean")) {
                    CategoryView(title: "Ocean Waves")
                }

                NavigationLink(destination: SoundView(title: "Birds Chirping", audioFile: "birds.mp3", backgroundImage: "bird")) {
                    CategoryView(title: "Birds Chirping")
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct CategoryView: View {
    let title: String
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isDarkMode ? Color.green.opacity(0.42) : Color("DarkGreen").opacity(0.8))
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

