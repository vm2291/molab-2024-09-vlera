import SwiftUI

struct SleepLogView: View {
    @Binding var sleepLogs: [SleepLog]

    var body: some View {
        VStack {
            Text("Sleeping Log")
                .font(.largeTitle)
                .padding()

            List(sleepLogs) { log in
                HStack {
                    Text(log.timestamp)
                    Spacer()
                    Text("\(formatDuration(log.sleepDuration))")
                }
            }
        }
    }

    func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        return "\(hours) hours \(minutes) minutes"
    }
}

