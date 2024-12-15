import SwiftUI

struct MainView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true // Default to dark mode

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            NatureAudiosView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Nature Sounds")
                }
            NatureTimeTrackerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Time Tracker")
                }
            NatureJournalView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Journal")
                }
        }
        .accentColor(.green)
        .preferredColorScheme(isDarkMode ? .dark : .light) // Apply theme
        .background(
            Color(isDarkMode ? Color(hex: "#212121") : .white) // Softer dark theme and light background
        )
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.index(after: hex.startIndex) // Skip '#'
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}

