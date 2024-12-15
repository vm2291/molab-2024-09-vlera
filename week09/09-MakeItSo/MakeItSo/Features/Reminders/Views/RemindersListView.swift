import SwiftUI

struct RemindersListView: View {
  @StateObject
  private var viewModel = RemindersListViewModel()

  @State
  private var isAddReminderDialogPresented = false

  @State
  private var editableReminder: Reminder? = nil

  @State
  private var toastMessage: String = ""
  @State
  private var showToast: Bool = false

  private func presentAddReminderView() {
    isAddReminderDialogPresented.toggle()
  }

  private func deleteReminder(_ reminder: Reminder) {
    viewModel.deleteReminder(reminder)
    toastMessage = "\"\(reminder.title)\" deleted successfully!"
    showToast = true
  }

  var body: some View {
    ZStack {
        List($viewModel.reminders) { $reminder in
            RemindersListRowView(
                reminder: $reminder,
                onDelete: { reminder in
                    deleteReminder(reminder)
                },
                onEdit: { reminder in
                    editableReminder = reminder
                }
            )
            .onChange(of: reminder.isCompleted) { newValue in
                viewModel.setCompleted(reminder, isCompleted: newValue)
            }
        }

      .toolbar {
        ToolbarItemGroup(placement: .bottomBar) {
          Button(action: presentAddReminderView) {
            HStack {
              Image(systemName: "plus.circle.fill")
              Text("New Reminder")
            }
          }
          Spacer()
        }
      }
      .sheet(isPresented: $isAddReminderDialogPresented) {
        EditReminderDetailsView { reminder in
          viewModel.addReminder(reminder)
        }
      }
      .sheet(item: $editableReminder) { reminder in
        EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
          viewModel.updateReminder(reminder)
        }
      }
      .tint(.red)

    
      if showToast {
        VStack {
          Spacer()
          Text(toastMessage)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.bottom, 50)
            .onAppear {
              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showToast = false
              }
            }
        }
        .animation(.easeInOut, value: showToast)
      }
    }
  }
}

