//
//  ChooserButton.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import UIKit
import SnapKit

class ChooserButton: UIButton {
    let chooserType: ChooserType
    
    init(chooserType: ChooserType) {
        self.chooserType = chooserType
        super.init(frame: .zero)
        
        let icon = UIImage(named: chooserType.icon)
        let text = chooserType.text
        let accessory = UIImage(named: "icon_chooser_plus")
        
        let iconImageView = UIImageView(image: icon)
        let textLabel = UILabel(frame: .zero)
        let accessoryView = UIImageView(image: accessory)
        
        self.backgroundColor = .primary1
        self.addSubview(iconImageView)
        self.addSubview(textLabel)
        self.addSubview(accessoryView)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.snp.leading).offset(12)
            make.width.height.equalTo(24)
        }
        textLabel.font = .body1Bold
        textLabel.textColor = .grey8
        textLabel.text = text
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(8)
        }
        accessoryView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(textLabel.snp.right).offset(14)
            make.right.equalTo(self.snp.right).offset(-18)
        }
        
        self.layer.cornerRadius = 24
        self.addShadow()
        self.layoutIfNeeded()
    }
    
    deinit {
        console("deinit chooser buton", self.chooserType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
