import SwiftUI
import SwiftData
import GoogleMaps

@main
struct HeronApp: App {
    init() {
        guard let gmsApiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String else {
            fatalError("Missing Google Maps API Key")
        }
        
        GMSServices.provideAPIKey(gmsApiKey)
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

struct MainTabView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(0)
            CoursesView()
                .tabItem {
                    Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath")
                    Text("Courses")
                }
                .tag(1)
            InfoView()
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Info")
                }
                .tag(2)
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis.circle")
                    Text("More")
                }.tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
