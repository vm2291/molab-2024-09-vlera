import SwiftUI

struct MainView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundColor(.green) // Replaced blue with green
                    Text("Home")
                }
            NatureAudiosView()
                .tabItem {
                    Image(systemName: "music.note")
                        .foregroundColor(.green)
                    Text("Nature Sounds")
                }
            NatureTimeTrackerView()
                .tabItem {
                    Image(systemName: "timer")
                        .foregroundColor(.green)
                    Text("Time Tracker")
                }
            NatureJournalView()
                .tabItem {
                    Image(systemName: "book")
                        .foregroundColor(.green)
                    Text("Journal")
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
