import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date()
    @State private var currentTime = Date()
    @State private var sleepDuration: TimeInterval = 0
    @State private var countdownStartTime: Date? // Tracks when the countdown starts
    @State private var countdownDuration: TimeInterval? // Tracks the duration of the set sleep
    @State private var isDurationSet = false // Tracks if the duration was set

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                Text("Sleep Scheduler")
                    .font(.largeTitle)
                    .padding()

                // Display Current Time
                Text("Current Time: \(currentTime, formatter: DateFormatter.timeFormatter)")
                    .font(.headline)
                    .padding()

                // Wake-Up Time Picker
                DatePicker("Wake Up Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .onChange(of: wakeUpTime) { _ in
                        calculateSleepDuration()
                    }

                // Display Sleep Duration
                Text("Sleep Duration: \(formattedSleepDuration)")
                    .font(.title)
                    .padding()

                // Set Sleep Duration Button
                Button(action: {
                    countdownStartTime = Date() // Set the current time as the start time
                    countdownDuration = sleepDuration // Lock the selected duration for the countdown
                    isDurationSet = true // Mark the duration as set
                }) {
                    Text(isDurationSet ? "Update Sleep Duration" : "Set This Sleep Duration")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                // Feedback Message
                if isDurationSet {
                    Text("Duration was set!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                }

                // Navigation Link to Countdown Page
                if let countdownStartTime = countdownStartTime, let countdownDuration = countdownDuration {
                    NavigationLink(
                        destination: CountdownView(startTime: countdownStartTime, duration: countdownDuration)
                    ) {
                        Text("View Sleep Duration Countdown")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
            }
            .onAppear(perform: updateTime)
            .padding()
        }
    }

    var formattedSleepDuration: String {
        let hours = Int(sleepDuration) / 3600
        let minutes = (Int(sleepDuration) % 3600) / 60
        return String(format: "%d hours %02d minutes", hours, minutes)
    }

    func updateTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.currentTime = Date()
            calculateSleepDuration()
        }
    }

    func calculateSleepDuration() {
        let calendar = Calendar.current
        var sleepTime = calendar.date(bySettingHour: calendar.component(.hour, from: wakeUpTime),
                                      minute: calendar.component(.minute, from: wakeUpTime),
                                      second: 0,
                                      of: currentTime) ?? currentTime

        if sleepTime <= currentTime {
            sleepTime = calendar.date(byAdding: .day, value:1, to: sleepTime) ?? sleepTime
        }

        sleepDuration = sleepTime.timeIntervalSince(currentTime)
    }
}
extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}

