//
//  Professional.swift
//  ProMed
//
//  Created by Luis Luna on 2/21/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Professional: Object {
    
    dynamic var idUsuario: String = ""
    dynamic var nombre: String = ""
    dynamic var email: String = ""
    dynamic var especialidad: String = ""
    dynamic var costo: Double = 0.0
    
    
  //  @objc dynamic var recentPatients = [Patient]()
    
    
    convenience init (idUsuario: String, nombre: String, email: String, especialidad: String, costo: Double) {
        self.init()
        
        self.idUsuario    = idUsuario
        self.nombre       = nombre
        self.email        = email
        self.especialidad = especialidad
        self.costo        = costo
       
    }
    
    func save() {
        if let realm = APIManager.shared.persistencia.realmBD() {
            if !realm.objects(Professional.self).isEmpty {
                
                try? realm.write {
                    realm.deleteAll()
                }
            }
            try? realm.write {
                realm.add(self)
            }
        }
    }
    
    
    
}
