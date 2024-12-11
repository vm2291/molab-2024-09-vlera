import SwiftUI

struct HomeView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true // For theme toggle
    @State private var totalNatureTimeToday: TimeInterval = 0 // Track today's total time

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
                        isDarkMode.toggle()
                    }) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .font(.title)
                            .foregroundColor(isDarkMode ? .yellow : .gray)
                            .padding()
                    }
                }

                Text("Nature Along Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Summary of Time in Nature
                NavigationLink(destination: NatureTimeDetailsView()) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Time in Nature")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(formatTime(totalNatureTimeToday))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Image(systemName: "leaf.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .preferredColorScheme(isDarkMode ? .dark : .light) // Apply light/dark theme
            .onAppear {
                totalNatureTimeToday = NatureTimeTrackerView.getTotalTimeForToday()
            }
        }
    }

    // Format time into hours, minutes, seconds
    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}

