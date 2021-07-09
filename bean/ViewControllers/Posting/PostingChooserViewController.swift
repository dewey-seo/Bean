//
//  PostingChooserViewController.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import UIKit

enum ChooserType {
    case photo
    case music
    case weather
    case place
    case thought
    
    var list: [ChooserType] {
        return [
            .place, .music, .photo, .weather, .thought
        ]
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

class PostingChooserViewController: BottomSlideViewController {

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
