import SwiftUI

@main
struct natApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true // Default dark mode

    var body: some Scene {
        WindowGroup {
            MainView()
                .accentColor(isDarkMode ? Color.green.opacity(0.9) : Color("DarkGreen").opacity(0.95))
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
        }
    }
}

