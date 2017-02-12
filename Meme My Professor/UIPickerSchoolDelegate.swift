//
//  UIPickerSchoolDelegate.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class UIPickerSchoolDelegate : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate{
    
    let schools = ["University of Southern California", "UCLA", "University of Washington", "Standford University", "California Polytechnic State University", "UCSD", "Harvard University", "Princeton University", "UC Davis", "UC Berkeley", "Cambridge University"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schools[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
