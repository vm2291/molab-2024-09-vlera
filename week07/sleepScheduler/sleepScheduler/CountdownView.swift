import SwiftUI
import PhotosUI

struct CountdownView: View {
    let sleepDuration: TimeInterval
    let countdownStartTime: Date
    var onLogSleep: ((TimeInterval) -> Void)

    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var hasLoggedSleep = false
    @State private var backgroundImage: UIImage?
    @State private var showPhotoPicker = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            if let image = backgroundImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }

            VStack {
                Text("Sleep Duration Countdown")
                    .font(.system(size: 45))
                    .foregroundColor(.white)
                    .padding()

                Text(timeString(time: remainingTime))
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)

                Button(action: stopAndLogSleep) {
                    Text("Stop and Log Sleep")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()

            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        showPhotoPicker = true
                    }) {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: startCountdown)
        .onDisappear(perform: stopTimer)
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(image: $backgroundImage)
        }
    }

    func startCountdown() {
        remainingTime = max(0, sleepDuration - Date().timeIntervalSince(countdownStartTime))
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 1 {
                remainingTime -= 1
            } else {
                stopTimer()
                if !hasLoggedSleep {
                    hasLoggedSleep = true
                    logSleepOnCountdownEnd()
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func stopAndLogSleep() {
        stopTimer()
        let elapsedTime = sleepDuration - remainingTime
        logSleepAndExit(elapsedTime: elapsedTime)
    }

    func logSleepOnCountdownEnd() {
        onLogSleep(sleepDuration)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            clearCountdownAndGoBack()
        }
    }

    func logSleepAndExit(elapsedTime: TimeInterval) {
        onLogSleep(elapsedTime)
        clearCountdownAndGoBack()
    }

    func clearCountdownAndGoBack() {
        UserDefaults.standard.removeObject(forKey: "countdownStartTime")
        UserDefaults.standard.removeObject(forKey: "sleepDuration")
        presentationMode.wrappedValue.dismiss()
    }

    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}

