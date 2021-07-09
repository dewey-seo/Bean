//
//  BottomSlideViewController.swift
//  bean
//
//  Created by dewey seo on 08/07/2021.
//

import UIKit
import SnapKit

class BottomSlideViewController: UIViewController {

    let DISMISS_VELOCITY_THRESHOLD: CGFloat = 1300
    
    var panGesture: UIPanGestureRecognizer?
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var topHandleView = UIView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.view.addGestureRecognizer(panGesture!)
        self.view.addSubview(topHandleView)
        
        topHandleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(60)
            make.height.equalTo(6)
            make.centerX.equalToSuperview()
        }
        topHandleView.backgroundColor = .grey3
        topHandleView.roundCorenrs(3)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0, let pointOrigin = pointOrigin else { return }
        
        view.frame.origin = CGPoint(x: 0, y: pointOrigin.y + translation.y)
        if (sender.state == .ended) {
            let dragVelocity = sender.velocity(in: view)
            if (dragVelocity.y >= DISMISS_VELOCITY_THRESHOLD) {
                self.dismiss(animated: true, completion: nil)
                return
            }
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
            }
        }
    }
}

extension BottomSlideViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomSlidePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
