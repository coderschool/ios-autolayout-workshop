//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Harley Trung on 4/1/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    var repo: GithubRepo! {
        didSet {
            nameLabel.text = repo.name
            forksLabel.text = "\(repo.forks!)"
            descLabel.text = repo.repoDescription
            if let url = NSURL(string: repo.ownerAvatarURL!) {
                picImageView.setImageWithURL(url)
            }
        }
    }
}
