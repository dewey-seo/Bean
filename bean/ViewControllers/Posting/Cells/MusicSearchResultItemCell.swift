//
//  MusicSearchResultItemCell.swift
//  bean
//
//  Created by dewey seo on 24/06/2021.
//

import UIKit

class MusicSearchResultItemCell: UITableViewCell {

    static var reuseIdentifier = "MusicSearchResultItemCell"
    var music: Music? {
        didSet {
            setMusic()
        }
    }
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnail.roundCorenrs(8)
        titleLabel.font = .headline1
        titleLabel.textColor = .black
        descriptionLabel.font = .caption1
        descriptionLabel.textColor = .grey7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setMusic() {
        if let music = music {
            let _ = try? thumbnail.kf.setImage(with: music.thumbnail.asURL())
            self.titleLabel.text = music.trackName
            self.descriptionLabel.text = music.artistName
        }
    }
}
