//
//  PatoentTableViewCell.swift
//  ProMed
//
//  Created by Luis Luna on 5/12/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var patientName: UILabel!
    
    @IBOutlet weak var patientGender: UILabel!
    
    
    @IBOutlet weak var patientAge: UILabel!
    
    
    @IBOutlet weak var patientNSS: UILabel!
    
    
    @IBOutlet weak var patientImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
