//
//  Patient.swift
//  ProMed
//
//  Created by Luis Luna on 2/23/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
/// Represents a patient and gives access to private information and records
class Patient {
    
    var idPaciente: String
    let nombre: String
    var email: String
    var telefono: String
    var nacimiento: Date
    var genero: String
    var nss: String
    var descripcion: String
    
    
    
    init (idPaciente: String, nombre: String, email: String, telefono: String, nacimiento: Date, genero: String, nss: String, descripcion: String ) {
        self.idPaciente  = idPaciente
        self.nombre      = nombre
        self.email       = email
        self.telefono    = telefono
        self.nacimiento  = nacimiento
        self.genero      = genero
        self.nss         = nss
        self.descripcion = descripcion
    }
    
    
    
}
