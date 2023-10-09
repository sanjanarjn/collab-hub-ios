//Copyright © 2021 Apple Inc. All rights reserved.

import Foundation
import SwiftUI
import WebKit

struct WebView: View {
    var urlString: String
    
    var body: some View {
        WebViewContainer(urlString: urlString)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebViewContainer: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewContainer

        init(_ parent: WebViewContainer) {
            self.parent = parent
        }
    }
}
