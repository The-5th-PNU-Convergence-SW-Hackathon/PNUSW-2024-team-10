import SwiftUI

struct CoursesFiltersView: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Filter", systemImage: "line.3.horizontal.decrease.circle", action: {
            isPresented = true
        })
            .labelStyle(.iconOnly)
            .font(.title2.weight(.light))
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                List {
                    Section(header: Text("Zone")) {
                        Text("Original Downtown")
                        Text("Haeundae, Gwangalli")
                        Text("Gijang, Sonjeong")
                        Text("Geumjeong")
                    }
                    Section(header: Text("Theme")) {
                        Text("History")
                        Text("Nature")
                        Text("Culture")
                        Text("Shopping")
                    }
                }
                .navigationBarTitle("Filters")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isPresented = false
                        } label: {
                            Text("Clear")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresented = false
                        } label: {
                            Text("Apply")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CoursesFiltersView()
}
