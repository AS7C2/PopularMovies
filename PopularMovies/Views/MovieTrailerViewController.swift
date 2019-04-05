//
//  MovieTrailerViewController.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    var presenter: MovieTrailerPresenter!
    var webView: WKWebView!
    
    override func loadView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.userContentController = contentController
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.scrollView.isScrollEnabled = false
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getYouTubeKey()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done))
    }
    
    @objc func done() {
        presenter.closeTrailer()
    }
}

extension MovieTrailerViewController: MovieTrailerPresenterViewDelegate {
    func movieTrailerPresenter(presenter: MovieTrailerPresenter, didGetYouTubeKey youTubeKey: String) {
        playTrailer(youTubeKey: youTubeKey)
    }
    
    func playTrailer(youTubeKey: String) {
        let filePath = Bundle.main.path(forResource: "YouTubePlayer", ofType: "html")!
        let template = try! String(contentsOfFile: filePath)
        let contents = String(format: template, youTubeKey)
        webView.loadHTMLString(contents, baseURL: nil)
    }
}

extension MovieTrailerViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        presenter.closeTrailer()
    }
}
