import WebKit
import SwiftUI
import UIKit

struct InfoWebView: UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> WKWebView {
        let _colorScheme = UITraitCollection.current.userInterfaceStyle
        
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        
        webView.backgroundColor = .notionBackground
        webView.isOpaque = false
        webView.allowsBackForwardNavigationGestures = true
        
        webView.scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        
        let script = """
        function removeLinkButtons() {
            const topBar = document.querySelector("div.notion-topbar-mobile");
            
            if (topBar) {
                for (const node of topBar.childNodes) {
                    if (node.getAttribute("role") === "button") {
                        node.style.display = "none"
                    }
                }
            }
        }

        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.type === "childList" || mutation.type === "subtree") {
                    removeLinkButtons();
                }
            });
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });

        removeLinkButtons();
        """
        
        let userScript = WKUserScript(
            source: script,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: false
        )
        
        webView.configuration.userContentController.addUserScript(userScript)
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<InfoWebView>) {
        guard let url = URL(string: url) else { return }
        
        webView.load(URLRequest(url: url))
    }
}

#Preview {
    MainTabView(selection: 2)
}
