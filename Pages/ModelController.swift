import UIKit

class ModelController: NSObject, UIPageViewControllerDataSource {

    var experiments = NSMutableArray()
    var menuIndex = 0
    
    func shuffleArray(inout array: NSMutableArray) -> NSMutableArray
    {
        for var index = array.count - 1; index > 0; index--
        {
            // Random int from 0 to index-1
            var j = Int(arc4random_uniform(UInt32(index-1)))
            
            // Swap two array elements
            swap(&array[index], &array[j])
        }
        return array
    }

    override init() {
        super.init()
        // Create the data model.
        
                if let path = NSBundle.mainBundle().pathForResource("experiments", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                
                experiments.addObjectsFromArray(dict.objectForKey("experiments") as NSArray)
            }
        }
        
        shuffleArray(&experiments)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetArray", name: mySpecialNotificationKey, object: nil)
    }
    
    func resetArray() {
        if let path = NSBundle.mainBundle().pathForResource("experiments", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                experiments.removeAllObjects()
                experiments.addObjectsFromArray(dict.objectForKey("experiments") as NSArray)
            }
        }
        shuffleArray(&experiments)
     
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataViewController = viewController as? DataViewController {
            if let experiment: AnyObject = dataViewController.experiment {
                return self.experiments.indexOfObject(experiment)
            }
        }
        return NSNotFound
    }

    
    
    func menuController (storyboard: UIStoryboard) -> UIViewController {
        
  
        
        let menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as UIViewController
        
        return menuViewController
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.experiments.count == 0) || (index >= self.experiments.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as DataViewController
        dataViewController.experiment = self.experiments[index] as? NSDictionary
        
        return dataViewController
    }
    

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if fromMenu == true {
        var index = self.indexOfViewController(viewController)
        if (index == NSNotFound) {
            return nil
        }
        if (index == 0) {
            index = experiments.count - 1
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        } else {
            println("fromMenu is \(fromMenu)")
            fromMenu = true
            return self.viewControllerAtIndex(0, storyboard: viewController.storyboard!)
        }

    }
    
    

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if fromMenu == true {
            var index = self.indexOfViewController(viewController as DataViewController)
            if index == NSNotFound {
                index = 0
            }
            if removeExperiment == true {
                if index == 0 {

                    experiments.removeObjectAtIndex(experiments.count - 1)

                } else {

                    experiments.removeObjectAtIndex(index)

                }
                removeExperiment = false
            }
            
            index++
            if index == self.experiments.count {
                index = 0
            }

            return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        } else {
            println("fromMenu is \(fromMenu)")
            fromMenu = true
            return self.viewControllerAtIndex(0, storyboard: viewController.storyboard!)
        }
        
        
    }

}
