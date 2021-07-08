//
//  BottomSlideViewController.swift
//  bean
//
//  Created by dewey seo on 08/07/2021.
//

import UIKit

class BottomSlideViewController: UIViewController {
    
    let DISMISS_VELOCITY_THRESHOLD: CGFloat = 1300
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
    
    var contentView: UIView?
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contentView = self.contentView {
            contentView.addGestureRecognizer(self.panGesture)
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
