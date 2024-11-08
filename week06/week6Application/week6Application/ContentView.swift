import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date()
    @State private var sleepDuration: TimeInterval = 0
    @AppStorage("setSleepDuration") private var setSleepDuration: TimeInterval = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Set Wake-Up Time")
                    .font(.largeTitle)
                    .padding()
                
                DatePicker("Wake-Up Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                
                Button(action: calculateSleepDuration) {
                    Text("Set Sleep Time")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Text("Sleep Duration: \(Int(sleepDuration) / 3600) hours, \(Int(sleepDuration) % 3600 / 60) minutes, \(Int(sleepDuration) % 60) seconds")
                    .font(.title2)
                    .padding()
                
                NavigationLink(destination: CountdownView()) {
                    Text("Go to Countdown")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SleepLogView()) {
                    Text("Sleep Log")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    // Function to calculate sleep duration based on current time and selected wake-up time
    func calculateSleepDuration() {
        let now = Date()
        sleepDuration = wakeUpTime.timeIntervalSince(now)
        if sleepDuration < 0 { sleepDuration += 24 * 60 * 60 }
        
        setSleepDuration = sleepDuration 
    }
}
