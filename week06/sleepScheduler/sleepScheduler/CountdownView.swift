import SwiftUI

struct CountdownView: View {
    let sleepDuration: TimeInterval
    let countdownStartTime: Date
    var onLogSleep: ((TimeInterval) -> Void)

    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var hasLoggedSleep = false // Prevents duplicate logging
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Sleep Duration Countdown")
                .font(.largeTitle)
                .padding()

            Text(timeString(time: remainingTime))
                .font(.system(size: 60))
                .padding()

            Button(action: stopAndLogSleep) {
                Text("Stop Countdown and Log Sleep")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(perform: startCountdown)
        .onDisappear(perform: stopTimer)
    }

    func startCountdown() {
        remainingTime = max(0, sleepDuration - Date().timeIntervalSince(countdownStartTime))
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 1 { // Allow a small buffer
                remainingTime -= 1
            } else {
                stopTimer()
                if !hasLoggedSleep {
                    hasLoggedSleep = true
                    logSleepOnCountdownEnd()
                }
            }
            print("Remaining Time: \(remainingTime)")
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
        onLogSleep(sleepDuration) // Mimic button logging
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            clearCountdownAndGoBack()
        }
        print("Logging sleep duration: \(sleepDuration)")

    }


    func logSleepAndExit(elapsedTime: TimeInterval) {
        onLogSleep(elapsedTime) // Log the sleep duration using the callback
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

