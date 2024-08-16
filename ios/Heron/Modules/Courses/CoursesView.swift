import SwiftUI
import SwiftUIIntrospect

struct CoursesView: View {
    private var tabs = ["All", "Wish", "Done"]
    @State private var currentTab = "All"
    
    var body: some View {
        NavigationStack {
            List {
                CourseListItem(
                    title: "Art & Healing Tour",
                    imageURL: URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F15af9355-e1dd-4c9f-ada2-eb1bbfc0cbb2%2Fimage.png?table=block&id=0cc6f44d-9b59-4869-99ae-014466b1e80e&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2"),
                    zone: "Haeundae/Gwangalli",
                    duration: "Day Trip",
                    label: .all,
                    landmark: "Busan Cinema Center"
                )
                    .listRowInsets(EdgeInsets())
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
                    CoursesFiltersView()
                }
                .padding([.leading, .trailing], 16.0)
            }
        }
    }
}

#Preview {
    MainTabView(selection: 1)
}
