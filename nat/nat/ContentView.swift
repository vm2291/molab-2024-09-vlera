import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Nature Along")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                // Rain Category
                NavigationLink(destination: SoundView(title: "Rain", audioFile: "rain.mp3", backgroundImage: "rain")) {
                    CategoryView(title: "Rain")
                }
                
                // Ocean Waves Category
                NavigationLink(destination: SoundView(title: "Ocean Waves", audioFile: "ocean.mp3", backgroundImage: "ocean")) {
                    CategoryView(title: "Ocean Waves")
                }
                
                // Birds Chirping Category
                NavigationLink(destination: SoundView(title: "Birds Chirping", audioFile: "birds.mp3", backgroundImage: "bird")) {
                    CategoryView(title: "Birds Chirping")
                }
            }
            .padding()
            .navigationTitle("Home Page")
            .padding()
        }
    }
}

//Category Buttons
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

// Sound View
struct SoundView: View {
    let title: String
    let audioFile: String
    let backgroundImage: String

    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                Spacer()

                // Stop Audio Button
                Button(action: stopAudio) {
                    Text("Stop Audio")
                        .font(.title2)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear(perform: playAudio)
    }

    // Play Audio Function
    func playAudio() {
        if let path = Bundle.main.path(forResource: audioFile, ofType: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }

    // Stop Audio Function
    func stopAudio() {
        audioPlayer?.stop()
    }
}

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

