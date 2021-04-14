//
//  AccountTableViewCell.swift
//  Demo
//
//  Created by The App Experts on 14/04/2021.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(account:(name:String, email:String, dob:String, phone:String )) {
        lblName.text = account.name
        lblDob.text = account.dob
        lblEmail.text = account.email
        lblPhone.text = account.phone
    }

}
