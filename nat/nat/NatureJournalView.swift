import SwiftUI

struct NatureJournalView: View {
    @State private var journalText: String = ""
    let articles = [
        "Benefits of Nature on Mental Health",
        "How Spending Time Outdoors Improves Focus",
        "The Role of Nature in Reducing Stress"
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Nature Journal")
                    .font(.largeTitle)
                    .padding()

                // Articles Section
                List(articles, id: \.self) { article in
                    Text(article)
                }
                .frame(height: 200)

                // Journal Entry Section
                Text("Write Your Thoughts:")
                    .font(.headline)
                    .padding(.top)
                TextEditor(text: $journalText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Checklist")
        }
    }
}

