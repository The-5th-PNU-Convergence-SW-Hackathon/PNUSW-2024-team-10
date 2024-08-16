import SwiftUI

struct AccountInfoView: View {
    @State private var isSignInViewPresented: Bool = false
    
    var body: some View {
        Section("Account") {
            Button {
                isSignInViewPresented = true
            } label: {
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus")
                    Text("Sign In")
                }
                .sheet(isPresented: $isSignInViewPresented) {
                    SignInView()
                }
            }
        }
    }
}
