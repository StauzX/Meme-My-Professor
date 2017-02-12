//
//  ViewController.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController{
    
    @IBOutlet weak var majorPicker: UIPickerView!
    @IBOutlet weak var schoolPicker: UIPickerView!
    
    var schoolsDelegate: UIPickerSchoolDelegate!
    var majorsDelegate: UIPickerMajorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Options"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(processSearch))
        
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
    
    func processSearch(sender: UIBarButtonItem){
        let school = schoolsDelegate.schools[schoolPicker.selectedRow(inComponent: 0)]
        let major = majorsDelegate.majors[majorPicker.selectedRow(inComponent: 0)]
        
        let flattened_data = school + "_" + major
        let defaults = UserDefaults.standard
        
        let displayViewController = self.storyboard?.instantiateViewController(withIdentifier: "DisplayViewController") as! DisplayViewController
        
        if var memes = defaults.array(forKey: flattened_data){
            for i in 0 ..< memes.count  {
                let data = memes[i]
                let img_name = String(describing: data) + ".png"
                let filename = getDocumentsDirectory().appendingPathComponent(img_name)
                displayViewController.images.append(UIImage(contentsOfFile: filename.path)!)
            }
            
            self.navigationController!.pushViewController(displayViewController, animated:true)
        }else{
            let alertController = UIAlertController(title: "Error!", message:
                "There are no memes that match your search criteria", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

