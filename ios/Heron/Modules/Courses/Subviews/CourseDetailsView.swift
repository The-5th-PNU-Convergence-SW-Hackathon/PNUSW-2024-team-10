import SwiftUI
import SwiftUIIntrospect

struct CourseDetailsView: View {
    @State private var tableViewHeight: CGFloat = 0
    @State private var isSignInSheetEnabled: Bool = false
    @State private var isFoodSheetEnabled: Bool = false
    
    var title: String = "Art & Healing Tour"
    var thumbnail: URL? = URL(string: "https://futuristic-budget-d22.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F92a61ff1-a5fc-4b36-9910-db0f8218224b%2F15af9355-e1dd-4c9f-ada2-eb1bbfc0cbb2%2Fimage.png?table=block&id=0cc6f44d-9b59-4869-99ae-014466b1e80e&spaceId=92a61ff1-a5fc-4b36-9910-db0f8218224b&width=2000&userId=&cache=v2")
    var zone: String = "Original Downtown"
    var duration: String = "One Day"
    var themes: [PlaceThemeLabelType] = [.historic, .culture]
    var itinaries: [ItinaryItem] = [
        .init(
            title: "Oreok",
            description: "Beef bone soup",
            time: "12:00 ~ 12:30"
        ),
        .init(
            title: "Busan Museum of Art",
            description: "It is an art museum where you can see various exhibitions and works.",
            time: "13:00 ~ 14:00",
            mission: "Find BTS RM's signature in \"Lee Woo Hwan Space.\""
        ),
        .init(
            title: "Busan Cinema Center",
            description: "It is the place where the Busan International Film Festival will be held, and you can also watch movies.",
            time: "14:30 ~ 17:00",
            mission: "Book a movie or program you want to see yourself."
        ),
        .init(
            title: "Shinsegae (Centum City)",
            description: "It is a representative department store located in Centum City.",
            time: "17:10 ~ 18:10"
        ),
        .init(
            title: "Haeundae Wonjo Halmae Gukbab",
            description: "Beef and Rice soup",
            time: "18:20 ~ 19:00"
        ),
        .init(
            title: "Gunam-ro",
            description: "It is a busy street that connects Haeundae Station and Haeundae Beach.",
            time: "19:00 ~ 20:00"
        ),
        .init(
            title: "Haeundae Beach",
            description: "It is the most famous beach in Korea, which is visited by more than 10 million people every year.",
            time: "20:00 ~ 21:00"
        )
    ]
    
    var body: some View {
        List {
            Section(header:
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(title)")
                            .font(.title.bold())
                            .foregroundStyle(Color(.label))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    AsyncImage(url: thumbnail) { image in
                        image.image?.resizable()
                    }
                        .scaledToFit()
                        .clipped()
                        .clipShape(.rect(cornerRadius: 6))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(zone), \(duration)")
                            .font(.body)
                            .foregroundStyle(Color(.secondaryLabel))
                            
                        HStack {
                            ForEach(themes, id: \.self) { theme in
                                PlaceThemeLabelView(theme)
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                .textCase(.none)
            ) {}
            
            FoodSheetProvider(isPresented: $isFoodSheetEnabled) {
                Section(
                    header:
                        Text("Itinary")
                            .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                ) {
                    ForEach(itinaries, id: \.title) { itinary in
                        Button {
                            isFoodSheetEnabled = true
                        } label: {
                            ItinaryItemView(itinary)
                        }
                        .foregroundStyle(Color(.label))
                        .listRowInsets(EdgeInsets())
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "heart")
                }
                .foregroundStyle(Color(.systemGray))
            }
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: .zero) {
            VStack {
                Button {
                    isSignInSheetEnabled = true
                } label: {
                    Text("Sign in and Start This Course")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .scaledToFit()
                .sheet(isPresented: $isSignInSheetEnabled) {
                    SignInView()
                }
            }
            .padding(20)
        }
    }
}

struct CourseDetailsLink: View {
    var body: some View {
        NavigationLink {
            CourseDetailsView()
        } label: {
            EmptyView()
        }
        .opacity(0.0)
    }
}

#Preview {
    NavigationStack {
        CourseDetailsView()
    }
}
