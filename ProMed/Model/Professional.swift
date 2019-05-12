//
//  Professional.swift
//  ProMed
//
//  Created by Luis Luna on 2/21/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
class Professional {
    
    var idUsuario: String
    var nombre: String
    var email: String
    var especialidad: String
    var costo: Double
    
    
    var recentPatients = [Patient]()
    
    
    init (idUsuario: String, nombre: String, email: String, especialidad: String, costo: Double) {
        
        self.idUsuario    = idUsuario
        self.nombre       = nombre
        self.email        = email
        self.especialidad = especialidad
        self.costo        = costo
       
    }
    
    
    
}
