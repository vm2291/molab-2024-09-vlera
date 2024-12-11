import SwiftUI

struct NatureTimeDetailsView: View {
    @State private var selectedDate: Date = Date()
    @State private var timeForSelectedDate: TimeInterval = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Nature Time Details")
                .font(.largeTitle)
                .padding()

            // Selected Date and Time
            Text(formatTime(timeForSelectedDate))
                .font(.system(size: 50))
                .padding()

            Spacer()

            // Swipe Controls
            HStack {
                Button(action: {
                    if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                        selectedDate = newDate
                        fetchTimeForSelectedDate()
                    }
                }) {
                    Image(systemName: "arrow.left.circle")
                        .font(.largeTitle)
                }


                Spacer()

                Button(action: {
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
                        selectedDate = newDate
                        fetchTimeForSelectedDate()
                    }
                }) {
                    Image(systemName: "arrow.right.circle")
                        .font(.largeTitle)
                }

            }
            .padding()
        }
        .padding()
        .onAppear {
            fetchTimeForSelectedDate()
        }
    }

    func fetchTimeForSelectedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateKey = formatter.string(from: selectedDate)

        let defaults = UserDefaults.standard
        let logs = defaults.dictionary(forKey: "NatureTimeLogs") as? [String: TimeInterval] ?? [:]

        timeForSelectedDate = logs[dateKey, default: 0]
    }

    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}

