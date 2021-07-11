//
//  WeatherPostTableViewCell.swift
//  bean
//
//  Created by dewey seo on 10/07/2021.
//

import UIKit

class WeatherPostTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let reuseIdentifier = "WeatherPostTableViewCell"
    
    var post: Post? {
        didSet {
            setPost()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherLabel.setStyle(font: .body1Bold, color: .grey8, text: "took moment")
        weatherDescriptionLabel.setStyle(font: .caption2, color: .grey6, text: "")
        dateLabel.setStyle(font: .caption2, color: .grey6, text: "")
        weatherIcon.addBorderLine(color: .grey2)
        weatherIcon.roundCorenrs(3)
    }
    
    private func setPost() {
        if let post = post, let weather = post.weather {
            weatherLabel.text = weather.display.first?.title ?? ""
            weatherDescriptionLabel.text = weather.display.first?.description ?? ""
            dateLabel.text = post.createdAt.formattedString(.post)
            if let icon = weather.localIcon, let image = UIImage(named: icon) {
                weatherIcon.image = image
                return
            }
            let _ = try? weatherIcon.kf.setImage(with: weather.weatherIcon.asURL())
        }
    }
}
