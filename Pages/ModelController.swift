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
            // Notice '&' required as swap uses 'inout' parameters
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
        
        println(experiments)
        
        shuffleArray(&experiments)
        
        println(experiments)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetArray", name: mySpecialNotificationKey, object: nil)
    }
    
    func resetArray() {
        if let path = NSBundle.mainBundle().pathForResource("experiments", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                experiments.addObjectsFromArray(dict.objectForKey("experiments") as NSArray)
            }
        }
        shuffleArray(&experiments)
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let experiment: AnyObject = viewController.experiment {
            return self.experiments.indexOfObject(experiment)
        } else {
            return NSNotFound
        }
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
        
        if (menuIndex == 1) {
            return nil
        }
        menuIndex = 1
        
        return self.menuController(viewController.storyboard!)
    }
    
    

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if fromMenu == true {
            var index = self.indexOfViewController(viewController as DataViewController)
            if index == NSNotFound {
                return nil
            }
            
            index++
            if index == self.experiments.count {
                return nil
            }
            return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        } else {
            println("fromMenu is \(fromMenu)")
            fromMenu = true
            return self.viewControllerAtIndex(0, storyboard: viewController.storyboard!)
        }
        
        
    }

}
