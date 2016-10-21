import UIKit

class ResultViewController: UIViewController {
    
    public var babygander:String = "Boy"
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 55.0/255.0, green: 228.0/255.0, blue: 168.0/255.0, alpha: 1)
        
        resultButton.layer.masksToBounds = true
        resultButton.layer.cornerRadius = 4
        
        if babygander.isEqual("Boy") {
            bgImageView.image = UIImage(named: "boy")
            genderLabel.text = NSLocalizedString("result_boy", comment: "")
        }else{
            bgImageView.image = UIImage(named: "girl")
            genderLabel.text = NSLocalizedString("result_girl", comment: "")
        }
        UIView.translateView(view: resultButton, bundle: self.nibBundle!)
        // Do any additional setup after loading the view.
        let viewController:UIViewController = (self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2])!
        self.title = viewController.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "treeDots"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ChineseViewController.menu))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ChineseViewController.back))
        // Do any additional setup after loading the view.
    }
    
    func menu(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert);
        //default input textField (no configuration...)
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: NSLocalizedString("menu_item_2", comment: ""), style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            let popController:AboutViewController = (self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController"))! as! AboutViewController
            // set the presentation style
            popController.providesPresentationContextTransitionStyle = true
            popController.definesPresentationContext = true
            popController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(popController, animated: false, completion: nil)
        }));
        alert.addAction(UIAlertAction(title: "X", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            
        }));
        present(alert, animated: true, completion: nil);
    }
    
    func back(){
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
