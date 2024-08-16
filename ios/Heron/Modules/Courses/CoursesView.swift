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
                    label: .now,
                    landmark: "Busan Cinema Center"
                ).listRowInsets(EdgeInsets())
                CourseListItem(
                    title: "Modern and Contemporary History Tour of Busan",
                    imageURL: URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F58967660-9615-4bbb-ace2-d17dbb3621e2%2Fimage.png?table=block&id=c3cdda06-4561-48aa-a56c-c440d23eec7f&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2"),
                    zone: "Original Downtown",
                    duration: "Day Trip",
                    label: .wish,
                    landmark: "Busan Museum of Modern and Contemporary"
                ).listRowInsets(EdgeInsets())
                CourseListItem(
                    title: "Haeundae Ocean View Tour",
                    imageURL: URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F810b1310-be2a-4fd0-8509-7b4dbbe1f750%2Fimage.png?table=block&id=3b2e247d-b498-43e6-a734-4e132b6b02d3&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2"),
                    zone: "Haeundae/Gwangalli",
                    duration: "Day Trip",
                    label: .wish,
                    landmark: "Haeundae Beach"
                ).listRowInsets(EdgeInsets())
                CourseListItem(
                    title: "Tour of an exotic cultural village",
                    imageURL: URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2Fbc3cd5dd-e812-4dab-8eef-93ed34896fa2%2F6367a8b21e462af162160492daee66e6.png?table=block&id=04036b44-9b3c-48fb-8bb6-99e06c91ae65&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2"),
                    zone: "Original Downtown",
                    duration: "Day Trip",
                    label: .done,
                    landmark: "Huinnyeoul Culture Village"
                ).listRowInsets(EdgeInsets())
                CourseListItem(
                    title: "Analog, the value of lyricism and slowness",
                    imageURL: URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2Ffe23f9a6-2458-4531-ac29-2a93d611eab2%2Fimage.png?table=block&id=656ab5ce-9454-4008-a3f4-7331c7183199&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=1420&userId=&cache=v2"),
                    zone: "Original Downtown",
                    duration: "Overnight",
                    label: .none,
                    landmark: "Busan Air Cruise"
                ).listRowInsets(EdgeInsets())
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
