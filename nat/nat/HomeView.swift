import SwiftUI

struct HomeView: View {
    @AppStorage("NatureTimeLogs") private var logsData: String = "{}"
    @State private var logs: [String: [LogEntry]] = [:]
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("Nature Along")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    Spacer()

                    Button(action: { isDarkMode.toggle() }) {
                        Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                }
                .padding()

                NavigationLink(destination: NatureTimeDetailsView()) {
                    VStack (spacing: 15) {
                        Text("Time in Nature Today")
                            .font(.headline)
                            .foregroundColor(isDarkMode ? .white : .white)
                        Text(totalTimeToday())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(isDarkMode ? .white : .white)
                        Text("View More")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isDarkMode ? Color.green.opacity(0.2) : Color("DarkGreen").opacity(0.8))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                loadLogs()
            }
        }
    }

    func totalTimeToday() -> String {
        let today = formatDate(Date())
        let dayLogs = logs[today, default: []]
        let totalTime = dayLogs.reduce(0) { $0 + $1.duration }
        return formatDuration(totalTime)
    }

    func loadLogs() {
        if let data = logsData.data(using: .utf8),
           let decodedLogs = try? JSONDecoder().decode([String: [LogEntry]].self, from: data) {
            logs = decodedLogs
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }

    func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        return "\(hours) hr \(minutes) min \(seconds) s"
    }
}

