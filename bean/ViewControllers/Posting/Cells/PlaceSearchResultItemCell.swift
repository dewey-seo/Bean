//
//  PlaceSearchResultItemCell.swift
//  bean
//
//  Created by dewey seo on 12/07/2021.
//

import UIKit
import MapKit

class PlaceSearchResultItemCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    static let reuseIdentifier = "PlaceSearchResultItemCell"
    var item: MKMapItem? {
        didSet {
            setItem()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setSubViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSubViews() {
        self.iconView.image = UIImage(named: "location_pin")
        self.titleLabel.setStyle(font: .headline1, color: .black, text: "")
        self.descriptionLabel.setStyle(font: .caption1, color: .grey6, text: "")
    }
    
    func setItem() {
        guard let item = item else {
            // init
            return
        }
        titleLabel.text = item.name
        descriptionLabel.text = formattedAddressForPlacemark(placemark: item.placemark)
    }
    
}
