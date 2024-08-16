import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            List {
                AccountInfoView()
                ApplicationInfoView()
            }
            .navigationTitle("More")
        }
    }
}

#Preview {
    MainTabView(selection: 3)
}
