import SwiftUI

struct NatureTimeTrackerView: View {
    @State private var timeSpent: TimeInterval = 0
    @State private var timer: Timer?
    @State private var isTracking = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Nature Time Tracker")
                .font(.largeTitle)
                .padding()

            Text(formatTime(timeSpent))
                .font(.system(size: 50))
                .padding()

            if isTracking {
                Button(action: stopTracking) {
                    Text("Stop Tracking")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: startTracking) {
                    Text("Start Tracking")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }

    func startTracking() {
        isTracking = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeSpent += 1
        }
    }

    func stopTracking() {
        isTracking = false
        timer?.invalidate()
        timer = nil
        logTimeForToday(duration: timeSpent)
        timeSpent = 0 // Reset local timer after logging
    }

    func logTimeForToday(duration: TimeInterval) {
        let today = Date()
        let defaults = UserDefaults.standard
        var logs = defaults.dictionary(forKey: "NatureTimeLogs") as? [String: TimeInterval] ?? [:]

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateKey = formatter.string(from: today)

        logs[dateKey, default: 0] += duration
        defaults.set(logs, forKey: "NatureTimeLogs")
    }

    static func getTotalTimeForToday() -> TimeInterval {
        let today = Date()
        let defaults = UserDefaults.standard
        let logs = defaults.dictionary(forKey: "NatureTimeLogs") as? [String: TimeInterval] ?? [:]

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateKey = formatter.string(from: today)

        return logs[dateKey, default: 0]
    }

    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

