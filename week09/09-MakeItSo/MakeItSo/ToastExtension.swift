import SwiftUI

extension View {
    func toast(message: String, isPresented: Binding<Bool>, duration: Double = 2.0) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 50)
                        .transition(.opacity)
                }
                .animation(.easeInOut, value: isPresented.wrappedValue)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                isPresented.wrappedValue = false
            }
        }
    }
}

