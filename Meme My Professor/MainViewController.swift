//
//  ViewController.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickCreate(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Please select an action", preferredStyle: .actionSheet)
        
        let actionTakePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: openCamera)
        alertController.addAction(actionTakePhoto)
        
        let actionSelectPhoto = UIAlertAction(title: "Select From Photo Library", style: .default, handler: selectPhoto)
        alertController.addAction(actionSelectPhoto)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true)
    }
    
    @IBAction func onClickBrowse(_ sender: Any) {
        let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController!.pushViewController(searchViewController, animated:true)
    }
    
    func openCamera(alert: UIAlertAction!){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func selectPhoto(alert: UIAlertAction!){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let addTextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddTextViewController") as! AddTextViewController
        let screenSize: CGRect = UIScreen.main.bounds
        let heightOffset = CGFloat(60)
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let newImage = self.resizeImage(image: pickedImage, newWidth: CGFloat(750))
            addTextViewController.imageView = UIImageView()
            addTextViewController.imageView.contentMode = .scaleAspectFit
            addTextViewController.imageView.frame = CGRect(x:0, y:heightOffset, width:screenSize.width, height:screenSize.height / 4 * 3)
            addTextViewController.imageView.image = newImage
            addTextViewController.imageData = newImage
            addTextViewController.view.addSubview(addTextViewController.imageView)
        }
        
        dismiss(animated: true, completion: nil)
        self.navigationController!.pushViewController(addTextViewController, animated:true)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

