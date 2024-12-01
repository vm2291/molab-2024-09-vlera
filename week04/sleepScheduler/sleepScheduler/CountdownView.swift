import SwiftUI

struct CountdownView: View {
    let startTime: Date
    let duration: TimeInterval 
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
            Text("Sleep Duration Countdown")
                .font(.largeTitle)
                .padding()

            Text(timeString(time: remainingTime))
                .font(.system(size: 60))
                .padding()
        }
        .onAppear(perform: startCountdown)
        .onDisappear(perform: stopCountdown)
    }

    func startCountdown() {
        remainingTime = duration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let elapsedTime = Date().timeIntervalSince(startTime)
            remainingTime = max(0, duration - elapsedTime)

            if remainingTime == 0 {
                stopCountdown()
            }
        }
    }

    func stopCountdown() {
        timer?.invalidate()
        timer = nil
    }

    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

