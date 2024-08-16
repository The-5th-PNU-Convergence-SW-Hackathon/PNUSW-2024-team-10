import SwiftUI

struct FoodSheetProvider<Content: View>: View {
    var isPresented: Binding<Bool>
    @ViewBuilder var content: Content
    @State private var sheetHeight: CGFloat = .zero
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.isPresented = isPresented
        self.content = content()
    }
    
    var title: String = "Oreok"
    var placeId: String = "ChIJwek01K2SaDURtJMgxNliEKE"
    var address: String = "51, Marine city 3-ro, Haeundae-gu, Busan"
    var menu: String = "Beef bone soup"
    var zone: String = "Haeundae/Gwangalli"
    var foodLabels: [FoodLabelType] = [.vegan, .halal]
    var thumbnail: URL? = URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2Fce72307a-c587-4d9d-982a-0faab2ffab9c%2Fimage.png?table=block&id=60f07bce-6c8a-45b6-ac91-45f2b8d4c20c&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2")
    
    var body: some View {
        content
            .sheet(isPresented: isPresented) {
                VStack(spacing: 16) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(title)  ")
                            .font(.title2)
                            .bold()
                        + Text("[more](https://www.google.com/maps/search/?api=1&query=\(title)&query_place_id=\(placeId))")
                            .foregroundStyle(Color.accentColor)
                            .underline(true)
                            
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .font(.system(size: 22))
                                .foregroundStyle(Color(.systemGray))
                        }
                        .controlSize(.large)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.accentColor)
                                .frame(width: 18)
                            
                            Text(address)
                        }
                        
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Image(systemName: "fork.knife").foregroundStyle(Color.accentColor)
                                .frame(width: 18)
                            
                            Text(menu)
                        }
                    }
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    HStack {
                        ForEach(foodLabels, id: \.self) { label in
                            FoodLabelView(label)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(zone)
                        .font(.system(size: 16))
                        .foregroundStyle(Color(.systemGray))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    AsyncImage(url: thumbnail) { image in
                        image.image?.resizable()
                    }
                        .scaledToFill()
                        .clipped()
                        .frame(
                            width: .infinity,
                            height: 230
                        )
                        .clipShape(.rect(cornerRadius: 6))
                 }
                .padding([.horizontal], 16)
                .padding([.vertical], 24)
                 .overlay {
                     GeometryReader { geometry in
                         Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                     }
                 }
                 .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                     sheetHeight = newHeight
                 }
                 .presentationDetents([.height(sheetHeight)])
                 .presentationDragIndicator(.visible)
            }
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    FoodSheetProvider(isPresented: .constant(true)) {
        Text("This is the content")
            .padding()
    }
}

