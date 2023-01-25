//
//  ViewController.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 30.12.2022.
//

import UIKit
import Alamofire
// M ->
// V
// VM

class HomeVC: UIViewController {
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        initactiveIndicator()
    }
    
    @IBAction func araClick(_ sender: Any) {
        if let sehir = textField.text {
            viewModel.kktcDutyPharmacy(
                city: sehir,
                onLoading: { state in
                    if(state) {
                        self.activityIndicator.startAnimating()
                    } else {
                        self.activityIndicator.stopAnimating()
                    }
                },
                dataChanged: {
                    self.tableView.reloadData()
                }
            )
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

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pharmacyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dutyCell", for: indexPath) as! DutyPTableViewCell
        
        cell.labelName?.text = viewModel.pharmacyList[indexPath.row].name
        cell.labelKey?.text = viewModel.pharmacyList[indexPath.row].key
        cell.labelDist?.text = viewModel.pharmacyList[indexPath.row].dist
        cell.labelPhone?.text = viewModel.pharmacyList[indexPath.row].phone
        cell.labelAddress?.text = viewModel.pharmacyList[indexPath.row].address
        return cell
    }
}
