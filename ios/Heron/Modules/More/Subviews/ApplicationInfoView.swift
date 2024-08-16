import SwiftUI
import LicenseList

struct ApplicationInfoView: View {
    var body: some View {
        Section("Application") {
            LabeledContent("Version") {
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")
            }
            NavigationLink("Open Source License") {
                LicenseListView()
                    .licenseViewStyle(.withRepositoryAnchorLink)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarTitle("License")
            }
            Link("View Repository", destination: URL(string: "https://github.com/pnusw-hackathon/PNUSW-2024-team-10")!)
        }
    }
}
