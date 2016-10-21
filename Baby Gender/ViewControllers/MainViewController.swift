import UIKit
import GoogleMobileAds

class MainViewController: UIViewController {
    
    @IBOutlet weak var nutritionButton: UIButton!
    @IBOutlet weak var bloodbutton: UIButton!
    @IBOutlet weak var chineseButton: UIButton!
    var bannerViewTop: GADBannerView!
    var interstitial: GADInterstitial!
    
    private func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-1903586528289428/1358094197")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        //request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        //interstitial.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerViewTop = GADBannerView()
        bannerViewTop.adSize = kGADAdSizeSmartBannerPortrait
        bannerViewTop.center = CGPoint.init(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height - bannerViewTop.frame.size.height/2)
        bannerViewTop.adUnitID = "ca-app-pub-1903586528289428/4311560590"
        bannerViewTop.rootViewController = self
        bannerViewTop.load(GADRequest())
        self.view.addSubview(bannerViewTop)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = UIColor.init(red: 55.0/255.0, green: 228.0/255.0, blue: 168.0/255.0, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIView.translateView(view: self.view, bundle: self.nibBundle!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configure()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.createAndLoadInterstitial()
    }
    
    func configure() {
        nutritionButton.layer.masksToBounds = true
        nutritionButton.layer.borderWidth = 2
        nutritionButton.layer.borderColor = UIColor.white.cgColor
        nutritionButton.layer.cornerRadius = 5
    }
    
    @IBAction func chineseButtonClicked(_ sender: AnyObject) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        let viewController:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "ChineseViewController"))!
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func nutritionButtonClicked(_ sender: AnyObject) {

    }

    @IBAction func bloodButtonClicked(_ sender: AnyObject) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        let viewController:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "BloodViewController"))!
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
