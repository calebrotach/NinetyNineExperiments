import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    var experiment: NSDictionary?
    @IBOutlet weak var tlRightLine: UIImageView!
    
    @IBOutlet weak var tlLeftLine: UIImageView!
    
    @IBOutlet weak var brRightLine: UIImageView!
    @IBOutlet weak var brLeftLine: UIImageView!
    @IBAction func closeModal(segue:UIStoryboardSegue) {
        
    }
    
  
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)        
        if let dict: NSDictionary = experiment {
            if let title = dict.objectForKey("title") as? String {
                self.titleLabel!.text = title
            }
            if let body = dict.objectForKey("body") as? String {
                self.bodyLabel!.text = body
            }
        } else {
            self.titleLabel!.text = ""
            self.bodyLabel!.text = ""
        }
        
    }

}
