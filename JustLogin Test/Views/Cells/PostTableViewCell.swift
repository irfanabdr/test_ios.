//
//  PostTableViewCell.swift
//  JustLogin Test
//
//  Created by Irfan on 20/11/24.
//

import UIKit
import SDWebImage

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        contentLabel.text = post.content
        publishedAtLabel.text = post.publishedAt
        postImageView.sd_setImage(with: URL(string: post.thumbnail))
    }
    
}
