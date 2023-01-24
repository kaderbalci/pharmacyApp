//
//  ViewController.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 30.12.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    var pharmacyList = [DataResponse]() // Bış liste
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        initactiveIndicator()
    }
    @IBAction func araClick(_ sender: Any) {// "malatya"
        if let sehir = textField.text {
            kktcDutyPharmacy(city: sehir)
        }
    }
    
    func kktcDutyPharmacy(city :String){
        activityIndicator.startAnimating()
        let headers : HTTPHeaders = [
            "content-type" : "application/json",
            "authorization" : apiKey
        ]

        AF.request("\(basicURL)kktcDutyPharmacy?city=\(city)",method:.get,headers:headers).responseDecodable(of:DutyPharmacyResponse.self) { response in
            self.activityIndicator.stopAnimating()
            if let responseList = response.value?.result{
                self.pharmacyList = responseList
                self.tableView.reloadData()
            }
        }
    }
    
    func initactiveIndicator(){
        let container = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        activityIndicator.center = self.view.center
        container.addSubview(activityIndicator)
        self.view.addSubview(container)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dutyCell", for: indexPath) as! DutyPTableViewCell
        cell.labelName?.text = pharmacyList[indexPath.row].name
        cell.labelKey?.text = pharmacyList[indexPath.row].key
        cell.labelDist?.text = pharmacyList[indexPath.row].dist
        cell.labelPhone?.text = pharmacyList[indexPath.row].phone
        cell.labelAddress?.text = pharmacyList[indexPath.row].address
        return cell
    }
}
