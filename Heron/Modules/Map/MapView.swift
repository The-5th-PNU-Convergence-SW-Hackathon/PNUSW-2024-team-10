import SwiftUI
import GoogleMaps

struct MapView: View { 
    var body: some View {
        ZStack {
            GoogleMapsView()
                .ignoresSafeArea(.all)
        }
        .toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    MainTabView(selection: 0)
}
