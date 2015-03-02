// Playground - noun: a place where people can play

import Cocoa

 var experiments = NSMutableArray()

if let path = NSBundle.mainBundle().pathForResource("experiments", ofType: "plist") {
    if let dict = NSDictionary(contentsOfFile: path) {
        experiments.addObjectsFromArray(dict.objectForKey("experiments") as NSArray)
        
    }
}

println(experiments)






