//
//  Appointment.swift
//  ProMed
//
//  Created by Luis Luna on 3/26/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation

/// Appointment of a health professional and a patient in a given date
class Appointment {
    
    var idPatient: String
    var date: Date?
    var description: String
    
    init(idPatient: String, date: Date, description: String) {
        self.idPatient = idPatient
        self.date = date
        self.description = description
    }
    
}
