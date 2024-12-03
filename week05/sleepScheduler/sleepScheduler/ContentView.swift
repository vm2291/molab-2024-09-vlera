import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date()
    @State private var currentTime = Date()
    @AppStorage("countdownStartTime") private var storedStartTime: Date?
    @AppStorage("sleepDuration") private var storedSleepDuration: TimeInterval = 0
    @State private var sleepDuration: TimeInterval = 0
    @State private var isSleepDurationSet = false
    @State private var feedbackMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                Text("Sleep Scheduler")
                    .font(.largeTitle)
                    .padding()

                Text("Current Time: \(currentTime, formatter: DateFormatter.timeFormatter)")
                    .font(.headline)
                    .padding()

                DatePicker("Wake-Up Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()

                Text("Sleep Duration: \(formattedSleepDuration)")
                    .font(.title)
                    .padding()

                Button(action: {
                    setSleepDuration()
                }) {
                    Text(isSleepDurationSet ? "Update Sleep Duration" : "Set this sleep duration")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                if let message = feedbackMessage {
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                }

                if isCountdownActive {
                    NavigationLink(destination: CountdownView(sleepDuration: storedSleepDuration, countdownStartTime: storedStartTime ?? Date())) {
                        Text("View Sleep Duration Countdown")
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
            }
            .onAppear(perform: updateTime)
            .onAppear(perform: loadStoredValues)
        }
    }

    var formattedSleepDuration: String {
        let hours = Int(sleepDuration) / 3600
        let minutes = Int(sleepDuration) % 3600 / 60
        return String(format: "%d hours %02d minutes", hours, minutes)
    }

    var isCountdownActive: Bool {
        if let startTime = storedStartTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            return elapsedTime < storedSleepDuration
        }
        return false
    }

    func updateTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.currentTime = Date()
            self.calculateSleepDuration()
        }
    }

    func calculateSleepDuration() {
        let calendar = Calendar.current
        var sleepTime = calendar.date(bySettingHour: calendar.component(.hour, from: wakeUpTime),
                                      minute: calendar.component(.minute, from: wakeUpTime),
                                      second: 0,
                                      of: currentTime) ?? currentTime

        if sleepTime <= currentTime {
            sleepTime = calendar.date(byAdding: .day, value: 1, to: sleepTime) ?? sleepTime
        }

        sleepDuration = sleepTime.timeIntervalSince(currentTime)
    }

    func setSleepDuration() {
        storedStartTime = Date()
        storedSleepDuration = sleepDuration
        isSleepDurationSet = true
        feedbackMessage = "Sleep duration set!"
    }

    func loadStoredValues() {
        if let startTime = storedStartTime, storedSleepDuration > 0 {
            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime < storedSleepDuration {
                sleepDuration = storedSleepDuration
                isSleepDurationSet = true
            } else {
                storedStartTime = nil
                storedSleepDuration = 0
                isSleepDurationSet = false
            }
        }
    }
}

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
}
