//
//  AdditionalMenuViewController.swift
//  NinetyNineExperiments
//
//  Created by Caleb Rotach on 3/8/15.
//
//

import Foundation
import UIKit

let mySpecialNotificationKey = "com.example.specialNotificationKey"

class AdditionalMenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetArray", name: mySpecialNotificationKey, object: nil)
    }
    

    @IBAction func notify(){
        NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
    }
    
    func resetArray() {
        println("done")
    }
    
    
}

