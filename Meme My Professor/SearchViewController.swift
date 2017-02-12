//
//  ViewController.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit
import QuickLook

class SearchViewController: UIViewController, QLPreviewControllerDataSource{
    
    @IBOutlet weak var majorPicker: UIPickerView!
    @IBOutlet weak var schoolPicker: UIPickerView!
    
    var schoolsDelegate: UIPickerSchoolDelegate!
    var majorsDelegate: UIPickerMajorDelegate!
    
    var fileURLs = [NSURL]()
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURLs[index]
    }
    
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
        
        let quickLookController = QLPreviewController()
        fileURLs.removeAll()
        
        if var memes = defaults.array(forKey: flattened_data){
            for i in 0 ..< memes.count  {
                let data = memes[i]
                let img_name = String(describing: data) + ".png"
                let filename = getDocumentsDirectory().appendingPathComponent(img_name)
                
                fileURLs.append(filename as NSURL)
            }
            
            quickLookController.dataSource = self
            self.navigationController!.pushViewController(quickLookController, animated: true)
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

