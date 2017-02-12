//
//  ViewController.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class AddTextViewController: UIViewController, UITextFieldDelegate{
    
    var imageData: UIImage!
    var imageView: UIImageView!
    @IBOutlet weak var topLineField: UITextField!
    @IBOutlet weak var bottomLineField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add your text"
        self.topLineField.delegate = self
        self.bottomLineField.delegate = self
        topLineField.addTarget(self, action: #selector(topLineDidChange(_:)), for: .editingChanged)
        bottomLineField.addTarget(self, action: #selector(bottomLineDidChange(_:)), for: .editingChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(proceedWithChoice))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func topLineDidChange(_ textField: UITextField) {
        updateText()
    }
    
    func bottomLineDidChange(_ textField: UITextField) {
        updateText()
    }
    
    func updateText(){
        let screenSize: CGRect = UIScreen.main.bounds
        
        let topLineText = topLineField.text!
        let bottomLineText = bottomLineField.text!
        let temp = self.textToImage(drawText: topLineText as NSString, inImage: imageData, atPoint: CGPoint(x: screenSize.width / 2 - 200, y: 20))
        imageView.image = self.textToImage(drawText: bottomLineText as NSString, inImage: temp, atPoint: CGPoint(x: screenSize.width / 2 - 200, y: 850))
    }
    
    func textToImage(drawText text: NSString, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 100)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSStrokeColorAttributeName: UIColor.black,
            NSStrokeWidthAttributeName: CGFloat(5)
        ] as [String : Any]
        let textFontAttributes2 = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle,
        ] as [String : Any]

        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        text.draw(in: rect, withAttributes: textFontAttributes2)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func proceedWithChoice(sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: "Please select an action", preferredStyle: .actionSheet)
        
        let actionSave = UIAlertAction(title: "Save to Camera Roll", style: .default, handler: saveMeme)
        alertController.addAction(actionSave)
        
        let actionUpload = UIAlertAction(title: "Upload", style: .default, handler: uploadMeme)
        alertController.addAction(actionUpload)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true)
    }
    
    func saveMeme(alert: UIAlertAction!){
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        let alertController = UIAlertController(title: "Success!", message:
            "Your meme has been saved", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func uploadMeme(alert: UIAlertAction!){
        let uploadViewController = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController") as! UploadViewController
        uploadViewController.imageData = imageView.image
        self.dismiss(animated: true, completion: nil)
        self.navigationController!.pushViewController(uploadViewController, animated:true)
    }
    
}

