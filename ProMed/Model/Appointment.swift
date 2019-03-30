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
    
    var patient: Patient
    var professional: Professional
    var date: Date?
    var notes: String
    
    init(patient: Patient, professional: Professional, date: String, notes: String) {
        self.patient = patient
        self.professional = professional
        self.date = APIManager.shared.dateFormatDiaMesAnio().date(from: date)
        self.notes = notes
    }
    
}
