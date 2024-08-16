import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.heronPrimary)
                .ignoresSafeArea()
            
            Image(.heronBackground)
                .resizable()
                .scaledToFit()
                .padding(.leading, 20)
                .padding(.bottom, 60)
                .frame(minWidth: 0)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("Enjoy your life in Busan with Heron!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.top, 60)
                    Spacer()
                }
                
                Spacer()

                VStack(spacing: 16) {
                    Button {

                    } label: {
                        HStack {
                            Image(.googleIcon)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.black)
                            Text("Continue with Google")
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.white)
                    .controlSize(.large)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "applelogo")
                                .foregroundStyle(.black)
                            Text("Continue with Apple")
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.white)
                    .controlSize(.large)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("try Heron without sign in")
                            .foregroundStyle(Color.white)
                            .overlay(
                                Rectangle()
                                    .frame(height: 0.33, alignment: .bottom)
                                    .foregroundStyle(Color.white),
                                alignment: .bottom
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding([.horizontal, .bottom], 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SignInView()
}
