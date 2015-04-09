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
    
    @IBOutlet weak var resetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetArray", name: mySpecialNotificationKey, object: nil)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func resetAll(sender: AnyObject) {
        
        resetText.text = "The experiments have been reset. Tap the 'X' to continue."
        
    }
    

    @IBAction func notify(){
        NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
    }
    
    func resetArray() {
        println("done")
    }
    
    @IBAction func closeAdditionalMenu(segue:UIStoryboardSegue) {
        
    }

    
    
}

