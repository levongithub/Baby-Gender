import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(InfoViewController.tap)))
        self.view.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        UIView.translateView(view: self.view, bundle: self.nibBundle!)
    }
    
    func tap() {
        self.dismiss(animated: false, completion: nil)
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
