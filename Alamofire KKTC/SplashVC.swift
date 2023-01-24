//
//  SplashVC.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 10.01.2023.
//

import UIKit

class SplashVC: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var myString:NSString = "Welcome"
    var myMutableString = NSMutableAttributedString()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:5))
        welcomeLabel.attributedText = myMutableString
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "login") as LoginVC
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
            self.show(secondVC, sender: self)
        }
    }
}
