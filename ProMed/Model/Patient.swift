//
//  Patient.swift
//  ProMed
//
//  Created by Luis Luna on 2/23/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation

class Patient {
    
    var idPatient: String?
    let name: String!
    let birthDate: Date?
    
    required init(name: String, birthDate: String) {
        self.name = name
        self.birthDate = Date()
        self.idPatient = "1"
    }
    
    
    
}
