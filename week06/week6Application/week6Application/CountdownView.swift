import SwiftUI

struct CountdownView: View {
    @AppStorage("setSleepDuration") private var setSleepDuration: TimeInterval = 0
    @AppStorage("sleepLog") private var sleepLogData: String = "[]"
    
    @State private var remainingTime: TimeInterval = 0
    @State private var timerRunning = true
    
    var body: some View {
        VStack {
            Text("Remaining Sleep Time")
                .font(.title)

            Text("\(Int(remainingTime) / 3600) hours \(Int(remainingTime) % 3600 / 60) minutes \(Int(remainingTime) % 60) seconds")
                .font(.largeTitle)

            Button(action: stopAndLogSleep) {
                Text("Stop and Log Sleep")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear(perform: startTimer)
    }

    func startTimer() {
        remainingTime = setSleepDuration
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timerRunning {
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    timer.invalidate()
                }
            } else {
                timer.invalidate()
            }
        }
    }

    func stopAndLogSleep() {
        timerRunning = false
        
        let sleptTime = setSleepDuration - remainingTime
        
        let formattedTime = "\(Int(sleptTime) / 3600) hours \(Int(sleptTime) % 3600 / 60) minutes \(Int(sleptTime) % 60) seconds"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let logEntry = "\(formattedTime) on \(dateFormatter.string(from: Date()))"
        
        var logs = loadLogsFromJSON() ?? []
        
        logs.append(logEntry)

        saveLogsToJSON(logs: logs)
        
        print("Logged Sleep Entry:", logEntry)
    }

    func loadLogsFromJSON() -> [String]? {
        let decoder = JSONDecoder()
        
        if let data = sleepLogData.data(using: .utf8), let logs = try? decoder.decode([String].self, from: data) {
            return logs
        }

        return nil
    }

    func saveLogsToJSON(logs: [String]) {
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(logs), let jsonString = String(data: data, encoding: .utf8) {
            sleepLogData = jsonString
        }
    }
}
