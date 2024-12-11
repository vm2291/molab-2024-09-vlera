import SwiftUI
import AVFoundation

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

                Button(action: stopAudio) {
                    Text("Stop Audio")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear(perform: playAudio)
    }

    func playAudio() {
        guard let path = Bundle.main.path(forResource: audioFile, ofType: nil) else {
            print("Audio file not found: \(audioFile)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }

    func stopAudio() {
        audioPlayer?.stop()
    }
}

