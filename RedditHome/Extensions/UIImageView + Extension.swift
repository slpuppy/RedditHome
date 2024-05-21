//
//  Exntesion + UIImageView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, placeholder: UIImage? = nil) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        activityIndicator.hidesWhenStopped = true
        DispatchQueue.main.async {
            self.image = placeholder
            self.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
