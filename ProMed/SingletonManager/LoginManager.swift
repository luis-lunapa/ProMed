//
//  File.swift
//  ProMed
//
//  Created by Luis Luna on 5/12/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
import RealmSwift
import os

class LoginManager {
    
    func localLogin() -> Professional? {
        var user: Professional?
        
        
        guard let realm = APIManager.shared.persistencia.realmBD() else {
            os_log("No hay una instancia de realm", log: OSLog.reLogin, type: .info)
            
            return nil
        }
        
        //  performUIUpdatesOnMain {
        let listaLoca = realm.objects(Professional.self)
        if listaLoca.isEmpty {
            os_log("No hay ningún usuario para relogin", log: OSLog.reLogin, type: .info)
            
        } else {
            
            if let usuarioGuardado = listaLoca.first {
                
                user = Professional.init(idUsuario: usuarioGuardado.idUsuario, nombre: usuarioGuardado.nombre, email: usuarioGuardado.email, especialidad: usuarioGuardado.especialidad, costo: usuarioGuardado.costo)
                
            }
            
            
            
        }
        
        // }
        
        return user
    }
}
