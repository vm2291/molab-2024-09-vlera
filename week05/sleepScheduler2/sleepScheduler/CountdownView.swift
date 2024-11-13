//  SleepScheduler 2.0 - added seconds for more accuracy and also added app storage  as one of the homework requirements

import SwiftUI

struct CountdownView: View {
    @AppStorage("selectedDuration") private var selectedDuration: TimeInterval = 6 * 3600
    @AppStorage("remainingTime") private var remainingTime: TimeInterval = 0
    @State private var isCountingDown = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("Sleep Timer")
                .font(.largeTitle)
                .padding()

            if isCountingDown {
                Text(timeString(time: remainingTime))
                    .font(.system(size: 60))
                    .padding()
            } else {
                HStack {
                    ForEach([6, 7, 8], id: \.self) { hours in
                        Button(action: {
                            selectedDuration = TimeInterval(hours * 3600)
                            remainingTime = selectedDuration
                        }) {
                            Text("\(hours)h")
                                .foregroundColor(.white)
                                .padding()
                                .background(selectedDuration == TimeInterval(hours * 3600) ? Color.green : Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }

            Button(action: toggleTimer) {
                Text(isCountingDown ? "Stop" : "Start")
                    .foregroundColor(.white)
                    .padding()
                    .background(isCountingDown ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    func toggleTimer() {
        isCountingDown.toggle()
        if isCountingDown {
            remainingTime = selectedDuration
            startTimer()
        } else {
            stopTimer()
        }
    }

    func startTimer() {
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
        isCountingDown = false
    }

    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}

