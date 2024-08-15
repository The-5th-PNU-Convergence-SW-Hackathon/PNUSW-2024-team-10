import SwiftUI
import SwiftUIIntrospect
import Combine

struct ScrollViewDidScrollViewModifier: ViewModifier {
    
    class ViewModel: ObservableObject {
        var contentOffsetSubscription: AnyCancellable?
    }

    @StateObject var viewModel = ViewModel()
    var onScrollY: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .introspect(.scrollView, on: .iOS(.v17, .v18)) { scrollView in
                let topSafeArea = scrollView.safeAreaInsets.top
                
                if viewModel.contentOffsetSubscription == nil {
                    viewModel.contentOffsetSubscription = scrollView.publisher(for: \.contentOffset)
                    .sink { contentOffset in
                        onScrollY(contentOffset.y + topSafeArea)
                    }
                }
            }
    }
}

extension View {
    func onScrollY(_ onScrollY: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(ScrollViewDidScrollViewModifier(onScrollY: onScrollY))
    }
}
