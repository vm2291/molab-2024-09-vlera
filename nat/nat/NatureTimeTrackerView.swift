import SwiftUI

struct NatureTimeTrackerView: View {
    @State private var timeSpent: TimeInterval = 0
    @State private var timer: Timer?
    @State private var isTracking = false

    @AppStorage("NatureTimeLogs") private var logsData: String = "{}" // Store logs as a JSON string
    @State private var logs: [String: [LogEntry]] = [:] // Decoded logs

    @State private var currentDate: String = formatDate(Date())

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Nature Time Tracker")
                    .font(.largeTitle)
                    .padding()

                // Show today's date
                Text("Today: \(currentDate)")
                    .font(.headline)

                // Time tracking display
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

                Spacer()
            }
            .padding()
            .navigationTitle("") // Empty navigation title
            .navigationBarHidden(true) // Hides the navigation bar
            .onAppear {
                currentDate = NatureTimeTrackerView.formatDate(Date())
                loadLogs()
            }
        }
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

        // Log the session
        let log = LogEntry(startTime: Date(), duration: timeSpent)
        saveLog(for: currentDate, log: log)
        timeSpent = 0
    }

    func saveLog(for date: String, log: LogEntry) {
        var dayLogs = logs[date, default: []]
        dayLogs.append(log)
        logs[date] = dayLogs
        saveLogs()
    }

    func saveLogs() {
        if let data = try? JSONEncoder().encode(logs) {
            logsData = String(data: data, encoding: .utf8) ?? "{}"
        }
    }

    func loadLogs() {
        if let data = logsData.data(using: .utf8),
           let decodedLogs = try? JSONDecoder().decode([String: [LogEntry]].self, from: data) {
            logs = decodedLogs
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct LogEntry: Codable, Identifiable {
    let id = UUID()
    let startTime: Date
    let duration: TimeInterval
}

