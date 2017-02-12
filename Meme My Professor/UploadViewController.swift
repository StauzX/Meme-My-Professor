//
//  ViewController.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController{
    
    var imageData:UIImage!
    @IBOutlet weak var majorPicker: UIPickerView!
    @IBOutlet weak var schoolPicker: UIPickerView!
    
    var schoolsDelegate: UIPickerSchoolDelegate!
    var majorsDelegate: UIPickerMajorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Options"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(processUpload))
        
        schoolsDelegate = UIPickerSchoolDelegate()
        majorsDelegate = UIPickerMajorDelegate()
        
        schoolPicker.dataSource = schoolsDelegate
        schoolPicker.delegate = schoolsDelegate
        schoolPicker.selectRow(4, inComponent: 0, animated: false)
        
        majorPicker.dataSource = majorsDelegate
        majorPicker.delegate = majorsDelegate
        majorPicker.selectRow(4, inComponent: 0, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func processUpload(sender: UIBarButtonItem){
        let school = schoolsDelegate.schools[schoolPicker.selectedRow(inComponent: 0)]
        let major = majorsDelegate.majors[majorPicker.selectedRow(inComponent: 0)]
        
        let flattened_data = school + "_" + major
        let defaults = UserDefaults.standard
        
        var realCounter = 0;
        
        if defaults.integer(forKey: "counter") != nil {
            var counter = defaults.integer(forKey: "counter")
            defaults.set(counter + 1, forKey: "counter")
            realCounter = counter;
        }else{
            var counter = 0;
            defaults.set(counter + 1, forKey: "counter")
            realCounter = counter;
        }
        
        if var memes = defaults.array(forKey: flattened_data){
            print("does exist")
            memes.append(realCounter)
            defaults.set(memes, forKey: flattened_data)
        }else{
            defaults.set([realCounter], forKey: flattened_data)
            print("does not exist")
        }
        
        if let data = UIImagePNGRepresentation(imageData) {
            let filename = getDocumentsDirectory().appendingPathComponent(String(realCounter) + ".png")
            try? data.write(to: filename)
        }

        let alertController = UIAlertController(title: "Success!", message:
            "Your meme has been uploaded", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: popView))
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func popView(sender: UIAlertAction){
        self.navigationController?.popViewController(animated: true)
    }
    
}

