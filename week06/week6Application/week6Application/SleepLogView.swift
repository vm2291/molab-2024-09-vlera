import SwiftUI

struct SleepLogView: View {
    @AppStorage("sleepLog") private var sleepLogData: String = "[]" 

    var body: some View {
        VStack {
            Text("Sleep Log")
                .font(.largeTitle)
                .padding()

            List(loadLogsFromJSON(), id: \.self) { entry in
                Text(entry)
            }
            
            Spacer()
        }
        .navigationBarTitle("Sleep Log", displayMode: .inline)
    }

    func loadLogsFromJSON() -> [String] {
        let decoder = JSONDecoder()
        if let data = sleepLogData.data(using: .utf8), let logs = try? decoder.decode([String].self, from: data) {
            return logs
        }
        return []
    }
}
