//
//  RootViewController.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import RxSwift
import FirebaseAuth
import Lottie
import SnapKit

class RootViewController: UIViewController {
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "root-coffee")
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView?.snp.makeConstraints({ make in
            make.width.height.width.equalTo(200)
            make.center.equalToSuperview()
        })
        
        animationView!.play()
    }
}
