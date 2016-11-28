//
//  ViewController.swift
//  Camera
//
//  Created by Masahiro Furukawa on 2016/10/31.
//  Copyright © 2016年 redmage. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    var saveFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButtonAction(_ sender: AnyObject) {
        /*if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera is available.")
            let ipc = UIImagePickerController()
            ipc.sourceType = .camera
            ipc.delegate = self
            present(ipc , animated: true , completion: nil )
        } else {
            print("camera is not available.")
        }*/
        let alertController = UIAlertController(title: "Confirm", message: "Please select your action", preferredStyle: .actionSheet)
        
        //Camera option
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                let ipc:UIImagePickerController = UIImagePickerController()
                ipc.sourceType = .camera
                ipc.delegate = self
                self.present(ipc, animated: true, completion: nil)
                self.saveFlag = 1
            })
            alertController.addAction(cameraAction)
        }
        
        //Photo Library option
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                let ipc:UIImagePickerController = UIImagePickerController()
                ipc.sourceType = .photoLibrary
                ipc.delegate = self
                self.present(ipc, animated: true, completion: nil)
                self.saveFlag = 0
            })
            alertController.addAction(photoLibraryAction)
        }

        //Cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        //workaround app clash for ipad
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func tweetButtonAction(_ sender: AnyObject) {
        /*if let shareImage = imageView.image {
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)

            controller.popoverPresentationController?.sourceView = view
            present(controller , animated: true, completion: nil)
        }*/
        var controller:SLComposeViewController
        controller = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        controller.setInitialText("Today's picture")
        if (imageView.image != nil) {
            controller.add(imageView.image)
        }
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let image = imageView.image
        /*if (image != nil) {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
            //save to album
            UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
        }*/
        if image != nil && saveFlag > 0 {
            //save photo to library
            UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

