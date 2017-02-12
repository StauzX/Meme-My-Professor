//
//  ViewController.swift
//  Meme My Professor
//
//  Created by Tony on 2017-02-11.
//  Copyright © 2017 Team Meme. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController{
    
    var images:[UIImage] = []
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Memes"
        let screenSize: CGRect = UIScreen.main.bounds
        
        for i in 0 ..< images.count  {
            var imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x:0, y: CGFloat(i * 800), width: screenSize.width, height:screenSize.height / 4 * 3)
            imageView.image = images[i]
            self.scrollView.addSubview(imageView)
        }
        self.scrollView.contentSize = CGSize(width: screenSize.width, height: screenSize.height * CGFloat(images.count))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

