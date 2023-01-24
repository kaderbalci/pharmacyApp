//
//  DutyPTableViewCell.swift
//  Alamofire KKTC
//
//  Created by Kader BALCI on 30.12.2022.
//

import UIKit

class DutyPTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var labelDist: UILabel!
    @IBOutlet weak var labelName: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
