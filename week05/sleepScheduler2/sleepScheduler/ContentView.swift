//  SleepScheduler 2.0 - added seconds for more accuracy and also added app storage  as one of the homework requirements

import SwiftUI

struct ContentView: View {
    @AppStorage("wakeUpTime") private var wakeUpTime = Date()
    @State private var currentTime = Date()
    @AppStorage("sleepDuration") private var sleepDuration: TimeInterval = 0

    var body: some View {
        NavigationView {
            VStack {
                Text("Sleep Scheduler")
                    .font(.largeTitle)
                    .padding()

                Text("Current Time: \(currentTime, formatter: DateFormatter.timeFormatter)")
                    .font(.headline)
                    .padding()

                
                DatePicker("Wake Up Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()

                Text("Sleep Duration: \(formattedSleepDuration)")
                    .font(.title)
                    .padding()

                NavigationLink(destination: CountdownView()) {
                    Text("Go to Sleep Timer")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .onAppear(perform: updateTime)
        }
    }

    var formattedSleepDuration: String {
        let hours = Int(sleepDuration) / 3600
        let minutes = Int(sleepDuration) % 3600 / 60
        let seconds = Int(sleepDuration) % 60
        return String(format: "%d hours %02d minutes %02d seconds", hours, minutes, seconds)
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
}

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
}

