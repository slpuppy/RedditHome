//
//  HomeCollectionViewHeader.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 23/05/24.
//

import UIKit

class HomeCollectionViewHeader: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "REDDIT"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

