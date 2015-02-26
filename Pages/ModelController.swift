import UIKit

class ModelController: NSObject, UIPageViewControllerDataSource {

    var experiments = NSMutableArray()

    override init() {
        super.init()
        // Create the data model.
        if let path = NSBundle.mainBundle().pathForResource("experiments", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                experiments.addObjectsFromArray(dict.objectForKey("experiments") as NSArray)
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetArray", name: mySpecialNotificationKey, object: nil)
    }
    
    func resetArray() {
        if let path = NSBundle.mainBundle().pathForResource("experiments", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                experiments.addObjectsFromArray(dict.objectForKey("experiments") as NSArray)
            }
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
        
        
        
//So here we need to create an array that increments once and then saves. Then we see if there is anything there. If there is we don't let you pass.
//
        println(experiments.count)
//        println(experiments[experiments.count - 1])
//        
//        
//        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    
        return self.menuController(viewController.storyboard!)

        
        
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
//        var lastExperiment: DataViewController? = DataViewController()
//        
//        lastExperiment = nil
        
        
        
        if (experiments.count == 0) {
            return nil
        }
        
        if removeExperiment == true {
            experiments.removeObjectAtIndex(currentIndex)
            removeExperiment = false
        }

        
        let index = Int(arc4random_uniform(UInt32(experiments.count)))
        
        let currentExperiment = self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
        
        
//        lastExperiment = currentExperiment
        
        return currentExperiment
    }

}
