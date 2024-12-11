import SwiftUI
import Charts

struct NatureTimeDetailsView: View {
    @AppStorage("NatureTimeLogs") private var logsData: String = "{}"
    @State private var logs: [String: [LogEntry]] = [:]
    @State private var selectedDate: String = "" // Initialize as empty string

    var body: some View {
        VStack(spacing: 20) {
            Text("Time in Nature")
                .font(.largeTitle)
                .padding()

            Text("Date: \(selectedDate)")
                .font(.headline)

            if let dayLogs = logs[selectedDate], !dayLogs.isEmpty {
                // Log List
                List(dayLogs) { log in
                    HStack {
                        Text("Start: \(formatTime(log.startTime))")
                        Spacer()
                        Text("Duration: \(formatDuration(log.duration))")
                    }
                }

                // Graph Representation
                Chart {
                    ForEach(dayLogs) { log in
                        BarMark(
                            x: .value("Start Time", log.startTime),
                            y: .value("Duration", log.duration)
                        )
                        .foregroundStyle(Color.green)
                    }
                }
                .frame(height: 200)
            } else {
                Text("No logs for this day")
                    .font(.headline)
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: previousDate) {
                    Image(systemName: "arrow.left.circle")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                Spacer()
                Button(action: nextDate) {
                    Image(systemName: "arrow.right.circle")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            selectedDate = formatDate(Date()) // Initialize selectedDate here
            loadLogs()
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }

    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
    }

    func loadLogs() {
        if let data = logsData.data(using: .utf8),
           let decodedLogs = try? JSONDecoder().decode([String: [LogEntry]].self, from: data) {
            logs = decodedLogs
        }
    }

    func previousDate() {
        if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: parseDate(selectedDate)) {
            selectedDate = formatDate(newDate)
        }
    }

    func nextDate() {
        if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: parseDate(selectedDate)) {
            selectedDate = formatDate(newDate)
        }
    }

    func parseDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.date(from: dateString) ?? Date()
    }
}

