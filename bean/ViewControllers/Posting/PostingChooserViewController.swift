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
    
    var icon: UIImage {
        switch self {
        case photo:
        case music:
        case weather:
        case place:
        case thought:
        }
    }
    
    var text: String {
        
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
