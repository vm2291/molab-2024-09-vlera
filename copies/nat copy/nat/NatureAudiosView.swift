import SwiftUI

struct NatureAudiosView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Nature Sounds")
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
            .navigationTitle("Nature Sounds")
        }
    }
}

struct CategoryView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

