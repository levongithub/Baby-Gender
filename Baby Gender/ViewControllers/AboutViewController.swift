import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isSelectable = false
        textView.text = NSLocalizedString("what_is_it", comment: "") + "\n\n" + NSLocalizedString("china_about", comment: "") + "\n\n\n" + NSLocalizedString("china_about1", comment: "")
        textView.isSelectable = true
        textView.sizeToFit()
        self.view .addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(InfoViewController.tap)))
        self.view.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
