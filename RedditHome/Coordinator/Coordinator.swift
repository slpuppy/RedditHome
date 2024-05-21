//
//  Coordinator.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func start()
    
    func presentPost(postData: PostData)
}


