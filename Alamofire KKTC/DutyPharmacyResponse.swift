//
//  DutyPharmacy.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 1.01.2023.
//

import Foundation

struct DutyPharmacyResponse : Decodable {
    var success : Bool
    var result : [DataResponse]
}

struct DataResponse : Decodable {
    var name : String
    var dist : String
    var key : String
    var address : String
    var phone : String
}
