import SwiftUI
import SwiftUIIntrospect
import Combine

struct NavigationBottomViewModifier<BottomConent: View>: ViewModifier {
    @State private var scrollOffset: CGFloat = 0
    @State private var bottomBarHeight: CGFloat = 0
    let topbarHeight = UINavigationController().navigationBar.frame.height
    
    class ViewModel: ObservableObject {
        var contentOffsetSubscription: AnyCancellable?
    }

    @StateObject var viewModel = ViewModel()
    var bottomContent: () -> BottomConent
    var height: CGFloat
    var spacing: CGFloat
    
    func body(content: Content) -> some View {
        let opacity = interpolate(from: scrollOffset, inputRange:(topbarHeight - 3, topbarHeight), outputRange: (0, 1))
        
        content
            .introspect(.scrollView, on: .iOS(.v17, .v18)) { scrollView in
                let topSafeArea = scrollView.safeAreaInsets.top
                
                if viewModel.contentOffsetSubscription == nil {
                    viewModel.contentOffsetSubscription = scrollView.publisher(for: \.contentOffset)
                    .sink { contentOffset in
                        scrollOffset = contentOffset.y + topSafeArea
                    }
                }
            }
            .contentMargins(.top, height, for: .scrollIndicators)
            .safeAreaInset(edge: .top, spacing: spacing) {
                HStack(alignment: .center) {
                    bottomContent()
                }
                .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  maxHeight: height,
                  alignment: .center
                )
                .overlay(
                    Divider().opacity(opacity),
                    alignment: .bottom
                )
                .background(
                    .regularMaterial
                        .opacity(opacity)
                )
                .offset(y: max(-scrollOffset, 0))
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            
    }
}

extension View {
    func navigationBottom<BottomContent: View>(
        height: CGFloat,
        @ViewBuilder bottomContent: @escaping () -> BottomContent
    ) -> some View {
        self.modifier(NavigationBottomViewModifier(bottomContent: bottomContent, height: height, spacing: 0.0))
    }
    
    func navigationBottom<BottomContent: View>(
        height: CGFloat,
        spacing: CGFloat,
        @ViewBuilder bottomContent: @escaping () -> BottomContent
    ) -> some View {
        self.modifier(NavigationBottomViewModifier(bottomContent: bottomContent, height: height, spacing: spacing))
    }
    
}

#Preview {
    MainTabView(selection: 1)
}
