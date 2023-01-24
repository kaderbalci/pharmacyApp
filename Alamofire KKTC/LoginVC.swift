//
//  SignPageVC.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 12.01.2023.
//

import UIKit
import CoreData

class LoginVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        usernameTextField.layer.cornerRadius = 20.0
        usernameTextField.layer.borderWidth = 2.0
        usernameTextField.layer.borderColor = UIColor.white.cgColor
        usernameTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 20.0
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 15.0
        loginButton.layer.masksToBounds = true

        signUpButton.layer.cornerRadius = 15.0
        signUpButton.layer.masksToBounds = true
    }
    
    func checkUserInDatabase () -> Int{
        
        var count = 0
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bilgiler")

        let usernameKeyPredicate = NSPredicate(format: "username = %@", usernameTextField.text ?? "")
        let passwordKeyPredicate = NSPredicate(format: "password = %@", passwordTextField.text ??  "")
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [usernameKeyPredicate,passwordKeyPredicate])
        
        request.predicate = predicate
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            count = result.count
            print(result.count)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
            }
            
        }catch{
            print("Failed")
        }
        return count
    }
    
    @IBAction func button(_ sender: Any) {
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if checkUserInDatabase() == 1 {
            navigateToHome()
        }else{
            showLoginErrorAlert()
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gidilecekVc = storyboard.instantiateViewController(identifier: "register" ) as RegisterVC
        gidilecekVc.modalPresentationStyle = .fullScreen
        gidilecekVc.modalTransitionStyle = .crossDissolve
        show(gidilecekVc, sender: self)
    }
    
    private func showLoginErrorAlert() {
        
        let alertController = UIAlertController(title: "Username or password is incorrect", message: "Try again!", preferredStyle: .alert
        )
        
        let tamamAction = UIAlertAction(title: "Ok", style: .destructive) {
            action in
            print("Tamam tıklandı")
        }
        alertController.addAction(tamamAction)
        self.present(alertController, animated: true )
    }
    
    private func navigateToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "home") as ViewController
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        show(secondVC, sender: self)
    }
}
