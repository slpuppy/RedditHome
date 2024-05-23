//
//  RedditHomeViewController.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit
import SwiftUI

class RedditHomeViewController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel: RedditHomeViewModelProtocol
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: "HomePostCell")
        collectionView.register(HomeCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
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
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        self.fetchPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: UI Setup
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex: "171717")
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60)) // Adjust the height as needed
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
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
                    self.reloadPosts()
                }
            case .failure(let error):
                handleError(error: error)
            }
        }
    }
    
    private func presentPost(post: RedditPost){
        let vc = PostDetailsViewController(postData: post.data)
        navigationController?.pushViewController(vc, animated: true)
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
    private func reloadPosts() {
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadSections(.init(integer: 0))
        }, completion: nil)
    }
    
    
}

// MARK: Delegate methods

extension RedditHomeViewController: HomePostCellDelegate {
    func didLoadImage() {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}

extension RedditHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePostCell", for: indexPath) as? HomePostCell else {
            return UICollectionViewCell()
        }
        let post = viewModel.posts[indexPath.item]
        cell.delegate = self
        cell.layer.cornerRadius = 10
        cell.configure(with: post.data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presentPost(post: viewModel.posts[indexPath.item])
    }
    
}

extension RedditHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         guard kind == UICollectionView.elementKindSectionHeader else {
             fatalError("Unexpected supplementary view kind")
         }
         let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! HomeCollectionViewHeader
         return headerView
     }
    
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
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}





