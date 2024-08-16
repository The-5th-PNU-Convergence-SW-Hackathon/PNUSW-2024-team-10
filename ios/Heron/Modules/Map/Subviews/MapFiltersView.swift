import SwiftUI

struct MapFiltersButton: View {
    @State private var isPresented = false
    
    var body: some View {
        MapChip(
            text: "Filter",
            icon: Image(systemName: "line.3.horizontal.decrease"),
            type: .iconOnly,
            onChange: { _ in
                isPresented.toggle()
            }
        )
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                List {
                    Section(header: Text("Tour Spot / Theme")) {
                        Text("History")
                        Text("Nature")
                        Text("Culture")
                        Text("Shopping")
                    }
                    Section(header: Text("Restaurant / Type")) {
                        Text("Single seater")
                        Text("Halal")
                        Text("Vegan")
                        Text("Blue Ribbon Survey")
                        Text("Michelin Guide")
                    }
                    Section(header: Text("Restaurant / Cuisine")) {
                        Text("Korean")
                        Text("Chinese")
                        Text("Japanese")
                        Text("Western")
                        Text("Asian")
                        Text("Etc.")
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
    MapFiltersButton()
}
