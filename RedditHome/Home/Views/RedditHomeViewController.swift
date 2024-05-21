//
//  RedditHomeViewController.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit

class RedditHomeViewController: UIViewController {
    
    private var viewModel: RedditHomeViewModelProtocol
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: "HomePostCell")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(hex: "171717")
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    
    // MARK: Initialization
    
    init(viewModel: RedditHomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        self.fetchPosts()
    }
    
    // MARK: UI Setup
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex: "171717")
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(260))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(260))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems = [footer]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // MARK: Private methods
    
    private func fetchPosts() {
        Task {
            let result = await self.viewModel.loadPosts()
            switch result {
            case .success:
                await MainActor.run {
                    self.refreshControl.endRefreshing()
                    self.reloadArticles()
                }
            case .failure(let error):
                handleError(error: error)
            }
        }
    }
    
    @objc private func handleRefresh() {
        fetchPosts()
    }
    
    @MainActor
    private func handleError(error: Error) {
        self.refreshControl.endRefreshing()
        if let newsError = error as? APIErrorResponse {
            self.showAlert(title: "An Error ocurred", message: newsError.message ?? "Unknown error")
        } else {
            self.showAlert(title: "Unknown Error", message: "An unknown error occurred.")
        }
    }

    @MainActor
    private func reloadArticles() {
        self.collectionView.performBatchUpdates {
            self.collectionView.reloadSections(.init(integer: 0))
        }
    }
    
}

// MARK: Delegate methods

extension RedditHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePostCell", for: indexPath) as? HomePostCell else {
            return UICollectionViewCell()
        }
        
        let post = viewModel.posts[indexPath.item]
        cell.configure(with: post.data)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.presentPost(postIndex: indexPath.item)
    }
    
}

extension RedditHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension RedditHomeViewController {
    
    func scrollToTop(completion: (() -> Void)? = nil) {
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion?()
        }
    }
    
    func shouldScrollToTop() -> Bool {
        let yOffsetThreshold: CGFloat = 16
        return collectionView.contentOffset.y > yOffsetThreshold
    }
    
    func scrollToTopIfNeeded(completion: (() -> Void)? = nil) {
        if shouldScrollToTop() {
            scrollToTop(completion: completion)
        } else {
            completion?()
        }
    }
}

extension RedditHomeViewController {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}





