import UIKit

var removeExperiment = false

var resetAll = false



class DataViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    var experiment: NSDictionary?
    @IBOutlet weak var tlRightLine: UIImageView!
    
    @IBOutlet weak var tlLeftLine: UIImageView!
    
    @IBOutlet weak var brRightLine: UIImageView!
    @IBOutlet weak var brLeftLine: UIImageView!
    
    @IBOutlet weak var doneLabel: UITextView!
    @IBOutlet weak var bodyTest: UITextView!
    @IBAction func closeModal(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func resetExperiments(unwindSegue:UIStoryboardSegue) {
        
        resetAll = true
        
    }

    
    @IBAction func removeExperimentSegue(unwindSegue:UIStoryboardSegue) {
        removeExperiment = true
    }
    
    
    
    @IBAction func closeMenu(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func closeFromX(segue:UIStoryboardSegue) {
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)        
        if let dict: NSDictionary = experiment {
            if let title = dict.objectForKey("title") as? String {
                self.titleLabel!.text = title
            }
            if let body = dict.objectForKey("body") as? String {
                self.bodyTest!.text = body
            }
        } else {
            self.titleLabel!.text = ""
            self.bodyLabel!.text = ""
        }
        
        if removeExperiment == true {
            doneLabel.text = "You've completed this experiment. You won't see it again unless you hit 'Reset' from the Home menu."
        }
        
        if resetAll == true {
            "Your experiments have been reset."
        }
        
        
    }
}
