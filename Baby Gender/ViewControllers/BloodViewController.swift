import UIKit

class BloodViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var circleShadowView: UIView!
    @IBOutlet weak var animateBgView: UIView!
    @IBOutlet weak var animateView: LoaderView!
    @IBOutlet weak var viewForText: UIView!
    @IBOutlet weak var momLabel: UILabel!
    @IBOutlet weak var dadLabel: UILabel!
    @IBOutlet weak var momTextField: UITextField!
    @IBOutlet weak var dadTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    var canCalculateMom:Bool = false
    var canCalculateDad:Bool = false
    var viewForTextYPossition:CGFloat!
    var timer:Timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 55.0/255.0, green: 228.0/255.0, blue: 168.0/255.0, alpha: 1)
        
        momLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BloodViewController.tapMomLabel)))
        dadLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BloodViewController.tapDadLabel)))
        
        dadTextField.delegate = self
        momTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(BloodViewController.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BloodViewController.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.addDoneButtonOnKeyboard()
        
        self.title = NSLocalizedString("secondMain", comment: "").replacingOccurrences(of: "\n", with: "")
        
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
    
    func process(){

        animateView.percent += 0.2;
        animateView.setNeedsDisplay()
        if animateView.percent > 100 {
            let numberAgeDad:Int = Int(dadTextField.text!)!
            let numberAgeMom:Int = Int(momTextField.text!)!
            var dadAgeDevided:CGFloat = 0
            var momAgeDevided:CGFloat = 0
            dadAgeDevided = (CGFloat(numberAgeDad) / 4
                - CGFloat(numberAgeDad / 4))
            momAgeDevided = (CGFloat(numberAgeMom) / 3
                - CGFloat(numberAgeMom / 3))
            
            let viewController:ResultViewController = (self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController"))! as! ResultViewController
            if momAgeDevided < dadAgeDevided {
                viewController.babygander = "Girl"
            }
            animateView.percent = 0
            animateBgView.isHidden = true
            timer.invalidate()
            mainView.isHidden = false
            self.navigationController?.pushViewController(viewController, animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func resultButtonClicked(_ sender: AnyObject) {
        if canCalculateDad && canCalculateMom {
            mainView.isHidden = true
            animateBgView.isHidden = false
            circleShadowView.layer.masksToBounds = true
            circleShadowView.layer.borderWidth = 20
            circleShadowView.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1).cgColor
            circleShadowView.layer.cornerRadius = circleShadowView.frame.size.width/2
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(BloodViewController.process), userInfo: nil, repeats: true)
            timer.fire()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIView.translateView(view: self.view, bundle: self.nibBundle!)
        UIView.translateView(view: progressLabel, bundle: self.nibBundle!)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewForTextYPossition = CGFloat(viewForText.frame.origin.y)

    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "X", style: UIBarButtonItemStyle.done, target: self, action: #selector(BloodViewController.doneButtonAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        momTextField.inputAccessoryView = doneToolbar
        dadTextField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let y = UIScreen.main.bounds.size.height - keyboardSize.size.height - viewForText.frame.size.height - 64
            if y < viewForTextYPossition{
                viewForText.frame = CGRect(origin: CGPoint(x:viewForText.frame.origin.x, y:y), size: viewForText.frame.size)
            }
            viewForText.superview?.updateConstraints()
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        viewForText.frame = CGRect(origin: CGPoint(x:viewForText.frame.origin.x, y:CGFloat(viewForTextYPossition)), size: viewForText.frame.size)
        viewForText.superview?.updateConstraints()
        
    }
    
    func tapMomLabel() {
        momLabel.isHidden = true
        momTextField.becomeFirstResponder()
    }
    
    func tapDadLabel() {
        dadLabel.isHidden = true
        dadTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let edge:Int? = Int(textField.text! + string)
        if textField.tag == 0{
            if (edge != nil) && edge! > 60 {
                return false
            }
        }else{
            if (edge != nil) && edge! > 70 {
                return false
            }
        }
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let edge:Int? = Int(textField.text!)
        if textField.tag == 0{
            if (edge != nil) && edge! >  15 && edge! < 61 {
                canCalculateMom = true
                textField.superview?.backgroundColor = UIColor.white
            }else{
                canCalculateMom = false
                textField.superview?.backgroundColor = UIColor.red
            }
        }else{
            if (edge != nil) && edge! >  15 && edge! < 71 {
                canCalculateDad = true
                textField.superview?.backgroundColor = UIColor.white
            }else{
                canCalculateDad = false
                textField.superview?.backgroundColor = UIColor.red
            }
        }
    }

}
