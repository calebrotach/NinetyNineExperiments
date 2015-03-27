//
//  MenuViewController.swift
//  Pages
//
//  Created by Caleb Rotach on 2/22/15.
//
//

import Foundation
import UIKit

//let mySpecialNotificationKey = "com.example.specialNotificationKey"

var fromMenu = false

class MenuViewController: UIViewController {
    
    @IBOutlet weak var arrowGif: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrowGif.animationImages = [UIImage]()
        
        for var index = 0; index < 300; index++ {
        
            var frameName = String(format: "animatedArrow_%05d", index)
            
            arrowGif.animationImages?.append(UIImage(named: frameName)!)
            
            arrowGif.animationDuration = 10
            arrowGif.startAnimating()
            
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetArray", name: mySpecialNotificationKey, object: nil)
    }

    @IBAction func notify(){
        NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
    }
    
    func resetArray() {
        println("done")
    }
    
        
    
}



