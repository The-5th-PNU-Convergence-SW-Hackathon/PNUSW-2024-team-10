import SwiftUI
import SwiftUIIntrospect

struct CoursesView: View {
    private var tabs = ["All", "Wish", "Done"]
    @State private var currentTab = "All"
    
    var body: some View {
        NavigationStack {
            List(0...40, id: \.self) { index in
                NavigationLink {
                    Text("\(index)(이)가 선택되었습니다!")
                } label: {
                    Text("\(index)")
                }
            }
            .navigationTitle("Courses")
            .navigationBottom(height: 48.0, spacing: 14.0) {
                HStack(alignment: .center, spacing: 16.0) {
                    Picker("", selection: $currentTab) {
                        ForEach(tabs, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Button("Filter", systemImage: "line.3.horizontal.decrease.circle", action: {})
                        .labelStyle(.iconOnly)
                        .font(.title2.weight(.light))
                }
                .padding([.leading, .trailing], 16.0)
            }
        }
    }
}

#Preview {
    MainTabView(selection: 1)
}
