//
//  UIPickerSchoolDelegate.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class UIPickerMajorDelegate : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate{
    
    let majors = ["Computer Science", "Architecture", "General", "Art & Science", "History", "Electrical Engineering", "Mechanical Engineering", "Biomedical Engineering", "Business Administration", "Civil Engineering", "Physics", "Chemistry", "Biology"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}
