//
//  SingUpPageVC.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 12.01.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate


class RegisterVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    var kullaniciBilgileri = [Bilgiler]()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var repeatTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 15.0
        emailTextField.layer.masksToBounds = true
        
        usernameTextField.layer.cornerRadius = 15.0
        usernameTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.masksToBounds = true
        
        repeatTextField.layer.cornerRadius = 15.0
        repeatTextField.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 15.0
        loginButton.layer.masksToBounds = true
        
        registerButton.layer.cornerRadius = 15.0
        registerButton.layer.masksToBounds = true
        registerButton.backgroundColor = UIColor.brown
        
        veriOkuma()
    }

    func veriKaydi(){
        let bilgi = Bilgiler(context: context)
        bilgi.your_email = emailTextField.text
        bilgi.password = passwordTextField.text
        bilgi.username = usernameTextField.text
        bilgi.repeat_password = repeatTextField.text
        
        appDelegate.saveContext()
    }
    
    func errorAlert(){
        let alertController = UIAlertController(title: "such a username already exists", message:"Re-enter username", preferredStyle: .alert)

        let tamamAction = UIAlertAction(title: "OK", style: .destructive ) { action in
            print("Tamam tıklandı")
        }
        
        alertController.addAction(tamamAction)
        self.present(alertController, animated: true)
      }
    
    func filter() -> Int {
        var count = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bilgiler")
        request.predicate = NSPredicate(format: "username = %@", usernameTextField.text ?? "")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            count = result.count
            for data in result as! [NSManagedObject]
            {
                print(data.value(forKey: "username") as! String)
            }
        } catch {
            print("Failed")
        }
        return count
    }
    
    func veriOkuma(){
        do {
            kullaniciBilgileri = try context.fetch(Bilgiler.fetchRequest())
        } catch  {
            print("Veri okurken  hata oluştu.")
        }
        for k in kullaniciBilgileri {
            print("Email : \(k.your_email!) - Username : \(k.username!) - Password : \(k.password!) - RepeatPassword : \(k.repeat_password!)")
            appDelegate.saveContext()
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if emailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != "" && repeatTextField.text != "" {
            if passwordTextField.text == repeatTextField.text {
                if filter() == 0 {
                    veriKaydi()
                    veriOkuma()
                    self.dismiss(animated: false, completion: nil)
                }else {
                 errorAlert()
                }
            }
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
