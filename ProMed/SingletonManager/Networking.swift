//
//  Networking.swift
//  ProMed
//
//  Created by Luis Luna on 5/12/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import os

//MARK: - URL tanto de prueba como funcionales
struct APIURL {
    static var luisUrl: String {
        let url = "https://www.luislunapa.com/universidad/rsa/ws1/"
        return url
        
    }
}

final class Networking {
    
    /**
     Validates email and password with server
     
     - Author:
     Luis Gerardo Luna
     
     - Parameters:
     
        - email: Email of the user
        - password: Password of the user
     
     - Returns:
     Promise <User>
     
     - Version:
     1.0
     
     - Copyright: Copyright © 2019 DeepTech.
     */
    
    func login(email: String, password: String) -> Promise<Professional> {
        
        var errorMessage = "Our server can not authenticate your account right now, try again"
        
        return Promise {
            seal in
            
            let parameters: [String: String] = [
                
                "email"     : email,
                "password"  : password,
                
                ]
            
            Alamofire.request(APIURL.luisUrl + "login.php", parameters: parameters).responseJSON {
                response in
                
                if let data = response.result.value {
                    let jsonData = JSON(data)
                    print("Resultado == \(jsonData)")
                    
                    let status = jsonData["status"].intValue
                    if status != 200 {
                        if status == 605 {
                            errorMessage = "Incorrect user or password"
                            
                        }
                        
                       
                        seal.reject(NSError(domain: "login", code: 0, userInfo: ["msg": errorMessage]))
                        
                    }
                    
                    let idUser = jsonData["data"]["idUser"].stringValue
                    let nombre = jsonData["data"]["nombre"].stringValue
                    let email = jsonData["data"]["email"].stringValue
                    let especialidad = jsonData["data"]["especialidad"].stringValue
                    let costo = jsonData["data"]["costo"].doubleValue
                    
                   
                    
                    let pro = Professional.init(idUsuario: idUser, nombre: nombre, email: email, especialidad: especialidad, costo: costo)
                    
         
                    
                    seal.fulfill(pro)
                    
                    
                } else {
                    os_log("login: Error al login email = %{PRIVATE}@  error = %{PRIVATE}@",
                           log: OSLog.login, type: OSLogType.error,
                           String(describing: email),
                           String(describing: response.error))
                    seal.reject(NSError(domain: "login", code: 0, userInfo: ["msg": errorMessage]))
                }
                
            }
            
            
            
        }
        
    }
    
    
    
}
