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
    
    var idAppointment: String
    var idPatient: String
    var date: Date?
    var description: String
    
    var nombrePaciente: String
    var nssPaciente: String
    
    init(idAppointment: String, idPatient: String, date: Date, description: String, nombrePaciente: String, nssPaciente: String) {
        self.idAppointment  = idAppointment
        self.idPatient      = idPatient
        self.date           = date
        self.description    = description
        
        self.nombrePaciente = nombrePaciente
        self.nssPaciente    = nssPaciente
    }
    
}
