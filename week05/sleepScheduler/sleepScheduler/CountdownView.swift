import SwiftUI

struct CountdownView: View {
    let sleepDuration: TimeInterval
    let countdownStartTime: Date

    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("Sleep Duration Countdown")
                .font(.largeTitle)
                .padding()

            Text(timeString(time: remainingTime))
                .font(.system(size: 60))
                .padding()

            Spacer()
        }
        .onAppear(perform: startCountdown)
        .onDisappear(perform: stopTimer)
    }

    func startCountdown() {
        remainingTime = max(0, sleepDuration - Date().timeIntervalSince(countdownStartTime))
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
