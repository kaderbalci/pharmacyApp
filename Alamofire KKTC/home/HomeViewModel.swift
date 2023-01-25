//
//  HomeViewModel.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 25.01.2023.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    var pharmacyList = [DataResponse]()
    
    func kktcDutyPharmacy(city :String, onLoading: @escaping (Bool) -> Void, dataChanged: @escaping () -> Void){
        onLoading(true)
        let headers : HTTPHeaders = [
            "content-type" : "application/json",
            "authorization" : apiKey
        ]

        AF.request("\(basicURL)kktcDutyPharmacy?city=\(city)",method:.get,headers:headers).responseDecodable(of:DutyPharmacyResponse.self) { response in
            onLoading(false)
            if let responseList = response.value?.result{
                self.pharmacyList = responseList
                dataChanged()
            }
        }
    }
}
