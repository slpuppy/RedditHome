//
//  PostDetailsViewController.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//

import UIKit
import SwiftUI

class PostDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    private var hostingController: UIHostingController<PostDetailsView>
    
    private var navigationTitle: String
    
    // MARK: Initialization
    
    init(postData: PostData) {
        let rootView = PostDetailsView(postData: postData)
        self.navigationTitle = postData.subreddit
        self.hostingController = UIHostingController(rootView: rootView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: navigationTitle)
        setup()
        setupConstraints()
    }
    
    // MARK: Setup
    
    private func setupNavigationBar(title: String) {
        self.title = "r/\(title)"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(hex: "212121")
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setup() {
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        self.hostingController.didMove(toParent: self)
        
    }
    
    private func setupConstraints() {
        self.hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
