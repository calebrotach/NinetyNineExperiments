//
//  MenuViewController.swift
//  Pages
//
//  Created by Caleb Rotach on 2/22/15.
//
//

import Foundation
import UIKit

let mySpecialNotificationKey = "com.example.specialNotificationKey"

var fromMenu = false

protocol MenuViewControllerDelegate {
    func didVisit(fromMenu: Bool)
}

class MenuViewController: UIViewController {
    

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



