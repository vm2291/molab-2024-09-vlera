import SwiftUI

struct RemindersListRowView: View {
    @Binding
    var reminder: Reminder
    @State private var showAlert = false

    var onDelete: (Reminder) -> Void
    var onEdit: (Reminder) -> Void

    var body: some View {
        HStack {
           
            Toggle(isOn: $reminder.isCompleted) {  }
                .toggleStyle(.reminder)
                .padding(.trailing, 8)

            Text(reminder.title)
                .strikethrough(reminder.isCompleted, color: .green)
                .foregroundColor(reminder.isCompleted ? .gray : .primary)
                .onTapGesture {
                    onEdit(reminder)
                }

            Spacer()

            // Trash button for deleting
            Button(action: {
                showAlert = true
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .alert("Delete Reminder?", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    onDelete(reminder)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct RemindersListRowView_Previews: PreviewProvider {
    struct Container: View {
        @State var reminder = Reminder.samples[0]
        var body: some View {
            List {
                RemindersListRowView(
                    reminder: $reminder,
                    onDelete: { _ in },
                    onEdit: { _ in }
                )
            }
        }
    }

    static var previews: some View {
        NavigationStack {
            Container()
        }
    }
}

