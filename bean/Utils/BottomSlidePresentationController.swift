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
        guard let containerView = self.containerView, let presentedView = self.presentedView else {
            return CGRect.zero
        }
        presentedView.autoresizingMask = [.flexibleWidth]
        
        let bounds = UIScreen.main.bounds
        let presentedRect = presentedView.bounds
        let origin = CGPoint(x: 0, y: bounds.height - presentedRect.height)
        let size = CGSize(width: containerView.frame.width, height: presentedRect.height)

        return CGRect(origin: origin, size: size)
    }
    
    override func presentationTransitionWillBegin() {
        blurEffectView.alpha = 0
        containerView?.addSubview(blurEffectView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.blurEffectView.alpha = 0.3
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.blurEffectView.alpha = 0
        }, completion: nil)
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
