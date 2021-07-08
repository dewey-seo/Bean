//
//  PopupViewController.swift
//  bean
//
//  Created by dewey seo on 08/07/2021.
//

import UIKit
import RxSwift
import SnapKit

protocol PopupViewControllerDelegate {
    func popupViewWillShow(view: UIView)
    func popupViewWillHide(view: UIView)
    func popupViewDidShow(view: UIView)
    func popupViewDidHide(view: UIView)
}

extension PopupViewControllerDelegate {
    func popupViewWillShow(view: UIView) {}
    func popupViewWillHide(view: UIView) {}
    func popupViewDidShow(view: UIView) {}
    func popupViewDidHide(view: UIView) {}
}

class PopupViewController: NSObject {
    static let shared: PopupViewController = PopupViewController()
    
    var delegate: PopupViewControllerDelegate?
    
    private let baseWindow: UIWindow = UIWindow.init()
    private let baseScrollView: UIScrollView = UIScrollView()
    private let backgourndView: UIView = UIView()
    private let firstPageView: UIView = UIView()
    private let secondPageView: UIView = UIView()
    
    private var willShowPopupView: UIView?
    private var showedPopupView: UIView?
    private var willHidePopupView: UIView?
    
    let disposBag = DisposeBag()
    
    override init() {
        super.init()
        baseWindow.isHidden = true
        baseWindow.backgroundColor = UIColor.clear
        
        backgourndView.backgroundColor = UIColor.black
        
        baseScrollView.backgroundColor = UIColor.clear
        baseScrollView.delegate = self
        baseScrollView.isPagingEnabled = true
        baseScrollView.showsVerticalScrollIndicator = false
        baseScrollView.delaysContentTouches = false
        baseScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:))))
        baseScrollView.addSubview(firstPageView)
        baseScrollView.addSubview(secondPageView)

        baseWindow.addSubview(self.backgourndView)
        baseWindow.addSubview(self.baseScrollView)
        
        backgourndView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        baseScrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        setKeyboardObserver()
    }
    
    private func showWindow() {
        baseWindow.makeKeyAndVisible()
        
        //        self.blurEffectView.layer.opacity = 0
        //        self.blurEffectView.layoutIfNeeded()
        backgourndView.layer.opacity = 0
        backgourndView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2) {
            //            self.backgourndView.layer.opacity = 1
            //            self.backgourndView.layoutIfNeeded()
            self.backgourndView.layer.opacity = 0.5
            self.backgourndView.layoutIfNeeded()
        }
    }
    
    private func hideWindow() {
        baseWindow.isHidden = true
        
        showedPopupView?.removeFromSuperview()
        showedPopupView = nil
        
        willShowPopupView?.removeFromSuperview()
        willShowPopupView = nil
        
        willHidePopupView?.removeFromSuperview()
        willHidePopupView = nil
    }
    
    private func prepareLayouts() {
        let bounds = UIScreen.main.bounds
        baseWindow.frame = bounds
        baseWindow.windowLevel = .alert
        
        firstPageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        secondPageView.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: bounds.height)
        baseScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        baseScrollView.contentOffset = CGPoint(x: 0, y: bounds.height)
        
        baseWindow.layoutIfNeeded()
    }
}

// MARK: - Show & Hide
extension PopupViewController {
    func showPopupView(popupView: UIView, animate: Bool) {
        self.prepareLayouts()
        
        if self.baseWindow.isHidden { self.showWindow() }
        
        willShowPopupView = popupView
        
        // Check already showed popupView
        if showedPopupView != nil {
            self.hidePopupView(animate: animate, completion: {
                self.startShowPopupView(animate: animate)
            })
        } else {
            self.startShowPopupView(animate: animate)
        }
    }
    
    func hidePopupView(animate: Bool, completion: (() -> Void)? = nil) {
        willHidePopupView = showedPopupView
        showedPopupView = nil
        startHidePopupView(animate: animate) { [weak self] in
            if self?.willShowPopupView != nil { // show call twice case
                self?.hideWindow()
            }
            completion?()
        }
    }
    
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        hidePopupView(animate: true)
    }
}

// MARK: - Show & Hide Detail
extension PopupViewController {
    private func startShowPopupView(animate: Bool) {
        guard let popupView = willShowPopupView else {
            hideWindow()
            return
        }
        
        // send noti to delegate
        delegate?.popupViewWillShow(view: willShowPopupView!)
        
        // 1> add to baseview for animated
        baseWindow.addSubview(popupView)
        baseWindow.layoutIfNeeded()
        
        var popupViewCenterY: Constraint?
        popupView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            popupViewCenterY = make.centerY.equalToSuperview().offset(baseWindow.frame.height * -1).constraint
            make.width.equalTo(popupView.frame.width)
            make.height.equalTo(popupView.frame.height)
        }
        baseWindow.layoutIfNeeded()
        
        if animate {
            // move to target location
            UIView.animate(withDuration: 0.35, animations: {
                popupViewCenterY?.update(offset: 0)
                self.baseWindow.layoutIfNeeded()
            }, completion: { (complete) in
                self.showedPopupView = popupView
                self.willShowPopupView = nil
                self.addShowedPopupviewToScrollViewCenter()
            })
        } else {
            self.showedPopupView = self.willShowPopupView
            self.willShowPopupView = nil

            // move to baseWindow To scrollView
            self .addShowedPopupviewToScrollViewCenter()
        }
    }
    
    private func startHidePopupView(animate: Bool, completion: (() -> Void)? = nil) {
        guard let popupView = willHidePopupView else {
            hideWindow()
            return
        }
        
        // send noti to delegate
        self.delegate?.popupViewWillHide(view: self.willHidePopupView!)
        
        // Scrollview To baseview Center
        popupView.removeFromSuperview()
        baseWindow.addSubview(popupView)
        
        var popupViewCenterY: Constraint?
        popupView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            popupViewCenterY = make.centerY.equalToSuperview().constraint
            make.width.equalTo(popupView.frame.width)
            make.height.equalTo(popupView.frame.height)
        }
        
        let movedContetnOffsetY = baseScrollView.contentSize.height * 0.5 - baseScrollView.contentOffset.y
        popupViewCenterY?.update(offset: movedContetnOffsetY)
        baseWindow.layoutIfNeeded()
        
        // Baseview center To bottom
        if animate {
            UIView.animate(withDuration: 0.35, animations: {
                if self.willShowPopupView == nil {
                    self.backgourndView.layer.opacity = 0
                }
                popupViewCenterY?.update(offset: self.baseWindow.frame.size.height)
                self.baseWindow.layoutIfNeeded()
            }, completion: { finished in
                self.willHidePopupView?.removeFromSuperview()
                
                self.delegate?.popupViewDidHide(view: self.willHidePopupView!)
                
                self.willHidePopupView = nil
                
                completion?()
            })
        } else {
            self.willHidePopupView?.removeFromSuperview()
            
            // send noti to delegate
            self.delegate?.popupViewDidHide(view: popupView)
            
            self.willHidePopupView = nil
            
            completion?()
        }
    }
    
    private func addShowedPopupviewToScrollViewCenter() {
        guard let popupView = self.showedPopupView else {
            hideWindow()
            return
        }
        
        popupView.removeFromSuperview()
        secondPageView.addSubview(popupView)
        popupView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(popupView.frame.width)
            make.height.equalTo(popupView.frame.height)
        }
        baseWindow.layoutIfNeeded()
        
        // send noti to delegate
        delegate?.popupViewDidShow(view: self.showedPopupView!)
    }
    
    private func checkNeedHidePopupViewWhenAfterDecelerating() {
        if(showedPopupView != nil && baseScrollView.contentOffset.y < baseScrollView.contentSize.height * 0.5) {
            self.hidePopupView(animate: true)
        }
    }
    
    // MARK: - Functions for popup animation
    private func moveViewToOverTop(popupView: UIView) {
        
    }
    
    private func moveViewToOriginLocation(popupView: UIView) {
        
    }
}
// MARK: - Keyboard
extension PopupViewController {
    func setKeyboardObserver() {
        KeyboardObserve.shared.observingKeyboardHeightChange()
            .subscribe { result in
                
            }
            .disposed(by: disposBag)
    }
    
    private func willShowKeyboard(height: CGFloat) {
    }
    
    private func willHideKeyboard(height: CGFloat) {
    }
}

// MARK: - ScrollView Delegate
extension PopupViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let backgroundAlpha = scrollView.contentOffset.y / scrollView.contentSize.height
        self.backgourndView.layer.opacity = Float(backgroundAlpha)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(decelerate == false) {
            self.checkNeedHidePopupViewWhenAfterDecelerating()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.checkNeedHidePopupViewWhenAfterDecelerating()
    }
}
