import SwiftUI

struct NatureAudiosView: View {
    var body: some View {
        NavigationView { // Ensure the NavigationView wraps the entire content
            VStack(spacing: 20) {
                Text("Nature Sounds")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white) // Title text color set to white
                    .padding()

                // Buttons for Rain, Ocean Waves, and Birds Chirping
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
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

struct CategoryView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white) // Always white text to ensure visibility
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green.opacity(0.8)) // Matches the rest of your app
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

