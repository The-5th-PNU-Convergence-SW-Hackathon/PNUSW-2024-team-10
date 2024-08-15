import SwiftUI

let infoURL: String = "https://futuristic-budget-d22.notion.site/ce0ed34714004a97b8156d5d824c8160?v=11eb5d1ffec14b5c8f961cd0613b0ceb&pvs=4"

struct InfoView: View {
    var body: some View {
        NavigationStack {
            InfoWebView(url: infoURL)
                .background(Color(.notionBackground))
                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    MainTabView(selection: 2)
}
