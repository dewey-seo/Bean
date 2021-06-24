//
//  MusicSearchResultItemCell.swift
//  bean
//
//  Created by dewey seo on 24/06/2021.
//

import UIKit

class MusicSearchResultItemCell: UITableViewCell {

    static var cellIdentifier = "MusicSearchResultItemCell"
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(_ model: Music) {
        let _ = try? thumbnail.kf.setImage(with: model.thumbnail.asURL())
        self.titleLabel.text = model.trackName
        self.descriptionLabel.text = model.artistName
    }
}
