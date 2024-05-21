//
//  HomePostCell.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit
import SDWebImage

protocol HomePostCellDelegate: AnyObject {
    func didLoadImage(postId: String)
}

class HomePostCell: UICollectionViewCell {
    
    weak var delegate: HomePostCellDelegate?
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var upVotesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var upVoteIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.up.circle"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    private lazy var upVotesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [upVoteIcon, upVotesLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6)
        stackView.backgroundColor = UIColor(hex: "171717")
        stackView.layer.cornerRadius = 12
        stackView.clipsToBounds = true
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints =  false
        return stackView
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
        contentView.addSubview(authorLabel)
        contentView.addSubview(upVotesStackView)
        contentView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: upVotesStackView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            upVotesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            upVotesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: upVotesStackView.bottomAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    var imageHeightAnchor: NSLayoutConstraint?
    
    func configure(with postData: PostData) {
        self.titleLabel.text = postData.title
        self.authorLabel.text = "\(postData.author) at r/\(postData.subreddit)"
        self.upVotesLabel.text = "\(postData.ups)"
        if let url = URL(string: postData.thumbnail) {
            if postData.thumbnail != "self" {
                imageView.isHidden = false
                self.imageView.downloaded(from: url, placeholder: UIImage(named: "placeholder")) { [weak self] image in
                    guard let self, let image else { return }
                    imageHeightAnchor?.isActive = false
                    imageHeightAnchor = imageView.heightAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: image.size.height / image.size.width)
                    imageHeightAnchor?.isActive = true
                }
            } else {
                imageView.isHidden = true
            }
        } else {
            
        }
    }
}
