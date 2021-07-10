//
//  MusicPostTableViewCell.swift
//  bean
//
//  Created by dewey seo on 10/07/2021.
//

import UIKit

class MusicPostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var musicDescriptionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    static let reuseIdentifier = "MusicPostTableViewCell"
    
    var post: Post? {
        didSet {
            self.setPost()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .primary1
        titleLabel.setStyle(font: .body1Bold, color: .grey8, text: "was listening...")
        dateLabel.setStyle(font: .caption2, color: .grey6)
        thumbnailImageView.roundCorenrs(8)
        musicTitleLabel.setStyle(font: .caption1Bold, color: .black)
        musicDescriptionLabel.setStyle(font: .caption2, color: .grey6)
        commentLabel.setStyle(font: .caption2Bold, color: .grey6, text: "")
    }
    
    private func setPost() {
        if let post = post, let music = post.music {
            dateLabel.text = post.createdAt.formattedString(.post)
            musicTitleLabel.text = music.trackName
            musicDescriptionLabel.text = music.artistName
            if let thumbnailUrl = try? music.thumbnail.asURL() {
                thumbnailImageView.kf.setImage(with: thumbnailUrl)
            }
        }
    }
}
