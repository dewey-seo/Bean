//
//  ImagePickerCoordinator.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

protocol ImagePickerCoordinatorDelegate: AnyObject {
    func didFinishPickingImage(_ image: UIImage, target: ImagePickerCoordinatorTarget)
    func pickerControllerDidCancel(_ target: ImagePickerCoordinatorTarget)
}

enum ImagePickerCoordinatorTarget {
    case unknown
    case posting
}

class ImagePickerCoordinator: NSObject, Coordinator {
    weak var delegate: ImagePickerCoordinatorDelegate?
    weak var parent: Coordinator?
    
    var target: ImagePickerCoordinatorTarget = .unknown
    var children = [Coordinator]()
    var router: Router
    
    lazy var imagePicker =  UIImagePickerController.init()
    
    // MARK: -
    init(from: Router?) {
        console("init - ImagePickerCoordinator")
        self.router = Router.init(fromViewController: from?.navigationController)
    }
    deinit {
        console("deinit - ImagePickerCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
        
//        self.router.navigationController.modalPresentationStyle = .overFullScreen
//        self.router.navigationController.modalTransitionStyle = .crossDissolve
//        self.router.navigationController.setNavigationBarHidden(true, animated: false)
//        self.router.present(tranparentVC, animated: true)
//        // TODO: - Make image picker coordinator
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
//            self.imagePicker.sourceType = .camera
//            self.imagePicker.mediaTypes = ["public.image"]
//            self.router.navigationController.present(self.imagePicker, animated: true, completion: nil)
//        }))
//        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { action in
//            self.imagePicker.sourceType = .savedPhotosAlbum
//            self.imagePicker.mediaTypes = ["public.image"]
//            self.router.navigationController.present(self.imagePicker, animated: true, completion: nil)
//        }))
        self.imagePicker.sourceType = .savedPhotosAlbum
        self.imagePicker.mediaTypes = ["public.image"]
        if let navc = imagePicker.navigationController {
            self.router.navigationController = navc
        }
        
        self.router.present(imagePicker, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.pickerControllerDidCancel(self.target)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            picker.dismiss(animated: true) { [weak self] in
                self?.router.dismiss(animated: true) {
                    guard let self = self else {
                        return
                    }
                    self.delegate?.didFinishPickingImage(image, target: self.target)
                }
            }
        } else {
            self.router.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.pickerControllerDidCancel(self.target)
            }
        }
    }
}

