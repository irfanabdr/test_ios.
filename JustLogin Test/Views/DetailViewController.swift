//
//  DetailViewController.swift
//  JustLogin Test
//
//  Created by Irfan on 20/11/24.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    static let segue = "toDetail"
    var post: Post?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView(with: post)
    }
    
    private func updateView(with post: Post?) {
        guard let post = post else { return }
        
        postImageView.sd_setImage(with: URL(string: post.image))
        titleLabel.text = post.title
        publishedAtLabel.text = post.publishedAt
        contentLabel.text = post.content
    }
    
}
