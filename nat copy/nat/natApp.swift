import SwiftUI

@main
struct natApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true // Default to dark mode

    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light) // Apply theme globally
                .environment(\.colorScheme, isDarkMode ? .dark : .light) // Ensure compatibility
        }
    }
}

