import SwiftUI
import GoogleMaps

struct MapView: View {
    @State private var isFavoriteOnly: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GoogleMapsView(
                latitude: 35.1731121,
                longitude: 129.0714122,
                zoom: 10.6,
                bearing: 23
            )
            .edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8.0) {
                    MapFiltersButton()
                    MapChip(
                        text: "Tour Spot",
                        icon: Image(systemName: "mappin.and.ellipse"),
                        isEnabled: true
                    )
                    MapChip(
                        text: "Restaurant",
                        icon: Image(systemName: "fork.knife"),
                        isEnabled: false
                    )
                }
                .padding(.horizontal, 16.0)
                .padding(.top, 6.0)
                .padding(.bottom, 15.0)
            }
            
            VStack(alignment: .trailing) {
                Spacer()
                MapChip(
                    text: "Favorites",
                    icon: Image(systemName: isFavoriteOnly ? "heart.fill" : "heart"),
                    type: .iconOnly,
                    isEnabled: isFavoriteOnly,
                    onChange: { isEnabled in
                        isFavoriteOnly = isEnabled
                    }
                )
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    MainTabView(selection: 0)
}
