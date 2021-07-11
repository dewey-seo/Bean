//
//  PostingChooserViewController.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import UIKit
import SnapKit

enum ChooserType {
    case photo
    case music
    case weather
    case place
    case thought
    
    var icon: String {
        switch self {
        case .photo: return "icon_chooser_photo"
        case .music: return "icon_chooser_music"
        case .weather: return "icon_chooser_weather"
        case .place: return "icon_chooser_place"
        case .thought: return "icon_chooser_thought"
        }
    }
    var text: String {
        switch self {
        case .photo: return "Photo"
        case .music: return "Music"
        case .weather: return "Weather"
        case .place: return "Place"
        case .thought: return "Dear, Diary"
        }
    }
}

protocol PostingChooserDelegate: AnyObject {
    func didSelectChooser(type: ChooserType)
}

class PostingChooserViewController: BottomSlideViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var marginB: NSLayoutConstraint!
    
    weak var delegate: PostingChooserDelegate?
    
    let displayChoosers: [ChooserType] = [.music, .photo, .weather, .place, .thought]
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
    }
    
    func setSubviews() {
        titleLabel.text = "\"What do you want to write?\""
        titleLabel.font = .headline1Bold
        titleLabel.textColor = .black
        
        let bounds = UIScreen.main.bounds
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.snp.makeConstraints { make in
            make.width.equalTo(bounds.width)
        }
        let stackViewWidth = bounds.width - 32
        
        let buttons = displayChoosers.map { type -> ChooserButton in
            let button = ChooserButton(chooserType: type)
            button.addTarget(self, action: #selector(ChooserButtonPressed(_:)), for: .touchUpInside)
            return button
        }
        
        addChooserButtons(containerWidth: stackViewWidth, marginH: 16, buttons: buttons)
        marginB.constant = 24 + safeAreaInsets.bottom
    }
    
    @objc func ChooserButtonPressed(_ sender: ChooserButton) {
        let type = sender.chooserType
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectChooser(type: type)
        }
    }
    
    func addChooserButtons(
        containerWidth: CGFloat, marginH: CGFloat, buttons: [UIView])
    {
        // grouping
        var colums: [[UIView]] = []
        var currentRow: [UIView] = []
        var startPoint: CGFloat = 0
        var currentWidth: CGFloat = 0
        let _ = buttons.enumerated().map({ (index, button) in
            // check is available add current row
            if(startPoint + button.frame.width > containerWidth) {
                colums.append(currentRow)
                // add row, and create new one
                currentRow = []
                startPoint = 0
                currentWidth = 0
            }
            
            // add button
            currentRow.append(button)
            currentWidth += button.frame.width
            startPoint += currentWidth + marginH
            
            // last
            if index == buttons.lastIndex() {
                colums.append(currentRow)
            }
        })
        
        colums.forEach { rows in
            let rowView = UIView()
            for (index, view) in rows.enumerated() {
                rowView.addSubview(view)
                if index == 0 {
                    view.snp.makeConstraints { make in
                        make.leading.top.bottom.equalToSuperview()
                    }
                } else if index == rows.lastIndex() {
                    let prev = rows[index - 1]
                    view.snp.makeConstraints { make in
                        make.leading.equalTo(prev.snp.trailing).offset(marginH)
                        make.top.bottom.trailing.equalToSuperview()
                    }
                } else {let prev = rows[index - 1]
                    view.snp.makeConstraints { make in
                        make.leading.equalTo(prev.snp.trailing).offset(marginH)
                        make.top.bottom.equalToSuperview()
                    }
                    
                }
            }
            stackView.addArrangedSubview(rowView)
        }
    }
}
