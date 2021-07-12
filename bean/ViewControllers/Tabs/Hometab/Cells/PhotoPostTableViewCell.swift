//
//  PhotoPostTableViewCell.swift
//  bean
//
//  Created by dewey seo on 10/07/2021.
//

import UIKit

class PhotoPostTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    static let reuseIdentifier = "PhotoPostTableViewCell"
    
    var post: Post? {
        didSet {
            setPost()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .primary1
        titleLabel.setStyle(font: .body1Bold, color: .grey8, text: "took moment")
        dateLabel.setStyle(font: .caption2, color: .grey6, text: "")
        commentLabel.setStyle(font: .caption2Bold, color: .grey6, text: "")
        photoImageView.roundCorenrs(8)
    }
    
    private func setPost() {
        guard let post = post, let photo = post.photo else {
            //init
            return
        }
        dateLabel.text = post.createdAt.formattedString(.post)
        if let url = try? photo.photoUrlString.asURL() {
            photoImageView.kf.setImage(with: url, placeholder: photo.gsImage)
        }
        commentLabel.text = photo.comment
    }
}
