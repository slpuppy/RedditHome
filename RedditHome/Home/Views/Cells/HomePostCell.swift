//
//  HomePostCell.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit
import SDWebImage

protocol HomePostCellDelegate: AnyObject {
   func didLoadImage()
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
        imageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
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
        stackView.layer.cornerRadius = 8
        stackView.layer.cornerCurve = .continuous
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
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var commentsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bubble.left"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
 
    private lazy var commentsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [commentsIcon, commentsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private var imageHeightConstraint: NSLayoutConstraint?
    
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
        contentView.addSubview(commentsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            authorLabel.leadingAnchor.constraint(equalTo: upVotesStackView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            upVotesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            upVotesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: upVotesStackView.bottomAnchor, constant: 12),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: commentsStackView.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            commentsStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 16),
            commentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
        imageView.isHidden = true
        imageHeightConstraint?.isActive = false
    }
    
    func configure(with postData: PostData) {
        configureLabels(with: postData)
        configureImageView(with: postData.thumbnail)
    }

    private func configureLabels(with postData: PostData) {
        titleLabel.text = postData.title
        authorLabel.text = "\(postData.author) at r/\(postData.subreddit)"
        upVotesLabel.text = "\(postData.ups)"
        commentsLabel.text = "\(postData.num_comments) comments"
    }

    private func configureImageView(with thumbnail: String) {
        guard let url = URL(string: thumbnail), !["self", "default"].contains(thumbnail) else {
            imageView.isHidden = true
            imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
            imageHeightConstraint?.isActive = true
            setNeedsLayout()
            layoutIfNeeded()
            delegate?.didLoadImage()
            return
        }
        
        imageView.isHidden = false
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder")) { [weak self] image, _, _, _ in
            guard let self = self, let image = image else { return }
            let aspectRatio = image.size.height / image.size.width
            self.imageHeightConstraint = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: aspectRatio)
            self.imageHeightConstraint?.isActive = true
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.delegate?.didLoadImage()
        }
    }
}
