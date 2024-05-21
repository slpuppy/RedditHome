//
//  HomePostCell.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit

class HomePostCell: UICollectionViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var imageOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0.7
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.backgroundColor = UIColor(hex: "212121")
        contentView.addSubview(image)
        contentView.addSubview(authorLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
            
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50)
        ])
        
        
    }

    func configure(with postData: PostData) {
        self.titleLabel.text = postData.title
        self.authorLabel.text = "\(postData.author) at \(postData.subreddit)"
        
        if let url = URL(string:postData.media?.oembed?.thumbnail_url ?? "" ){
            self.image.downloaded(from: url)
        }
   
    }
}

