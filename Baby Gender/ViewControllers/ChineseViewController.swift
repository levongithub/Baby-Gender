import UIKit

class ChineseViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate, UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var edgeLabel: UILabel!
    @IBOutlet weak var mounthLabel: UILabel!
    @IBOutlet weak var edgetextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var rotateImagwView: UIImageView!
    @IBOutlet weak var mounthPickerView: UIPickerView!
    @IBOutlet weak var momMLabel: UILabel!
    @IBOutlet weak var circleShadowView: UIView!
    @IBOutlet weak var animateBgView: UIView!
    @IBOutlet weak var animateView: LoaderView!
    var timer:Timer = Timer()
    
    @IBOutlet weak var viewForText: UIView!
    var mounth:Int = 1
    var canCalculate:Bool = false
    var viewForTextYPossition: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 55.0/255.0, green: 228.0/255.0, blue: 168.0/255.0, alpha: 1)
        
        edgeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChineseViewController.tapEdge)))
        mounthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChineseViewController.tapMounth)))
        rotateImagwView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChineseViewController.tapMounth)))
        
        mounthLabel.text = NSLocalizedString("jan", comment: "")
        mounthPickerView.delegate = self
        mounthPickerView.dataSource = self
        edgetextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChineseViewController.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChineseViewController.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.addDoneButtonOnKeyboard()
        
        self.title = NSLocalizedString("firstMain", comment: "").replacingOccurrences(of: "\n", with: "")
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configureSizes()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIView.translateView(view: resultButton, bundle: self.nibBundle!)
        UIView.translateView(view: edgeLabel, bundle: self.nibBundle!)
        UIView.translateView(view: momMLabel, bundle: self.nibBundle!)
        UIView.translateView(view: progressLabel, bundle: self.nibBundle!)
        
        viewForTextYPossition = CGFloat(viewForText.frame.origin.y)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func process(){
        animateView.percent += 0.2;
        animateView.setNeedsDisplay()
        if animateView.percent > 100 {
            animateView.percent = 0
            animateBgView.isHidden = true
            timer.invalidate()
            
            let viewController:ResultViewController = (self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController"))! as! ResultViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let key:NSString = (edgetextField.text! + String(mounth)) as NSString
            viewController.babygander = appDelegate.chineseDictionary[key as String]!
            mainView.isHidden = false
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }

    @IBAction func resultButtonClicked(_ sender: AnyObject) {
        if canCalculate {
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
    
    private func configureSizes(){
        infoButton.layer.masksToBounds = true
        infoButton.layer.cornerRadius = 4
        resultButton.layer.masksToBounds = true
        resultButton.layer.cornerRadius = 4
    }
    
    func tapEdge() {
        edgeLabel.isHidden = true
        edgetextField.becomeFirstResponder()
    }
    
    func tapMounth() {
        if mounthPickerView.isHidden {
            mounthPickerView.isHidden = false
            UIView.animate(withDuration: 0.4, animations: {
                self.rotateImagwView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            })
            
        } else {
            mounthPickerView.isHidden = true
            UIView.animate(withDuration: 0.4, animations: {
                self.rotateImagwView.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch row {
        case 0:
            return NSLocalizedString("jan", comment: "")
        case 1:
            return NSLocalizedString("feb", comment: "")
        case 2:
            return NSLocalizedString("mar", comment: "")
        case 3:
            return NSLocalizedString("apr", comment: "")
        case 4:
            return NSLocalizedString("may", comment: "")
        case 5:
            return NSLocalizedString("jun", comment: "")
        case 6:
            return NSLocalizedString("jun", comment: "")
        case 7:
            return NSLocalizedString("aug", comment: "")
        case 8:
            return NSLocalizedString("sep", comment: "")
        case 9:
            return NSLocalizedString("okt", comment: "")
        case 10:
            return NSLocalizedString("nov", comment: "")
        default:
            return NSLocalizedString("des", comment: "")

        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.tapMounth()
        mounth = row + 1
        mounthLabel.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "X", style: UIBarButtonItemStyle.done, target: self, action: #selector(ChineseViewController.doneButtonAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        edgetextField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction() {
        edgetextField.resignFirstResponder()
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let edge:Int? = Int(textField.text! + string)
        if (edge != nil) && edge! > 60 {
            return false
        }
        return true
 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let edge:Int? = Int(textField.text!)
        if (edge != nil) && edge! >  15 && edge! < 61 {
            canCalculate = true
            edgetextField.superview?.backgroundColor = UIColor.white
        }else{
            canCalculate = false
            edgetextField.superview?.backgroundColor = UIColor.red
        }
    }

    @IBAction func infoButtonPressed(_ sender: AnyObject) {
        let popController:InfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController"))! as! InfoViewController
        // set the presentation style
        popController.providesPresentationContextTransitionStyle = true
        popController.definesPresentationContext = true
        popController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popController, animated: false, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.currentContext
    }
}
