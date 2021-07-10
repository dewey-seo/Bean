//
//  MusicPopupView.swift
//  bean
//
//  Created by dewey seo on 10/07/2021.
//

import UIKit
import Kingfisher
import SnapKit
import AVFoundation

protocol MusicPopupViewDelegate: AnyObject {
    func musicPopupViewPostButtonPressed(popupView: MusicPopupView, model: Music)
}

class MusicPopupView: UIView, NibLoadable {
    weak var delegate: MusicPopupViewDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var avPlayer: AVPlayer?
    var model: Music? {
        didSet {
            setModel()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        setSubviews()
    }
    
    deinit {
        avPlayer?.pause()
    }
    
    func setSubviews() {
        self.roundCorenrs(12)
        contentView.backgroundColor = .primary1
        
        coverImageView.roundCorenrs(12)
        postButton.backgroundColor = .primary6
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.titleLabel?.font = .caption1Bold
    }
    
    func setModel() {
        guard let model = model else { return }
        let _ = try? self.coverImageView.kf.setImage(with: model.thumbnail.asURL())
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if let url = try? model?.previewUrl.asURL() {
            if avPlayer == nil {
                avPlayer = AVPlayer.init(url: url)
            }
            avPlayer?.play()
        }
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        guard let model = model else {
            return
        }
        self.delegate?.musicPopupViewPostButtonPressed(popupView: self, model: model)
    }
}
