import SwiftUI

struct ControlView: View {
    @Binding var comicSelected: Bool
    @Binding var monoSelected: Bool
    @Binding var crystalSelected: Bool
    @Binding var otherSelected: Bool
    @Binding var sepiaSelected: Bool  // New filter binding
    @Binding var pixellateSelected: Bool  // New filter binding
    @Binding var drawingSelected: Bool  // New Filter
    @Binding var vignetteSelected: Bool  // New Filter

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 12) {
                ToggleButton(selected: $comicSelected, label: "Comic")
                ToggleButton(selected: $monoSelected, label: "Mono")
                ToggleButton(selected: $crystalSelected, label: "Crystal")
                ToggleButton(selected: $otherSelected, label: "Other")
            }
            .padding(.bottom, 10)
            HStack(spacing: 12) {
                ToggleButton(selected: $sepiaSelected, label: "Sepia")  // New button
                ToggleButton(selected: $pixellateSelected, label: "Pixellate")  // New button
              ToggleButton(selected: $drawingSelected, label: "Drawing")  // New Button
              ToggleButton(selected: $vignetteSelected, label: "Vignette")  // New Button
            }
        }
    }
}

