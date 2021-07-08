//
//  BottomSlidePresentationController.swift
//  bean
//
//  Created by dewey seo on 08/07/2021.
//

import UIKit

class BottomSlidePresentationController: UIPresentationController {
    let blurEffectView: UIVisualEffectView
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let visualEffect = UIBlurEffect(style: .dark)
        self.blurEffectView = UIVisualEffectView(effect: visualEffect)
            
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        
        if let tapGestureRecognizer = tapGestureRecognizer {
            self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView else {
            return CGRect.zero
        }
        let origin = CGPoint(x: 0, y: containerView.frame.height * 0.4)
        let size = CGSize(width: containerView.frame.width, height: containerView.frame.height)
        
        return CGRect(origin: origin, size: size)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let presentedView = self.presentedView {
            presentedView.roundCorenrs([.topLeft, .topRight], radius: 22)
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        if let presentedView = self.presentedView, let containerView = self.containerView {
            presentedView.frame = frameOfPresentedViewInContainerView
            blurEffectView.frame = containerView.bounds
        }
    }
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
