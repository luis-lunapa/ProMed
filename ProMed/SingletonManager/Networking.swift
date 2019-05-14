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
        let url = "https://www.luislunapa.com/universidad/promed/ws1/"
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
    
    
    
    
    func getAllPatients() -> Promise<[Patient]> {
        var errorMessage = "Could not get all friends list"
        
        var patients = [Patient]()
        
        return Promise {
            seal in
            
            guard let user = APIManager.shared.persistencia.currentUser else {
                seal.reject(NSError(domain: "getAllPatients", code: 0, userInfo: ["msg": "Invalid login"]))
                return
            }
            
            let parameters: [String: String] = [
                
                "idUsuario"    : user.idUsuario
                
            ]
            
            Alamofire.request(APIURL.luisUrl + "getAllPatients.php", parameters: parameters).responseJSON {
                response in
                
                if let data = response.result.value {
                    let jsonData = JSON(data)
                    print("Resultado == \(jsonData)")
                    
                    let status = jsonData["status"].intValue
                    if status != 200 {
                        
                        
                        
                        os_log("getAllPatients: Status no fue el esperado = %{PRIVATE}@ mensaje = %{PRIVATE}@",
                               log: OSLog.login, type: OSLogType.error,
                               String(describing: status),
                               String(describing: jsonData["msg"].stringValue))
                        
                        seal.reject(NSError(domain: "getAllPatients", code: 0, userInfo: ["msg": errorMessage]))
                        
                    }
                    
                    let jsonPatients = jsonData["data"].arrayValue
                    
                    for patient in jsonPatients {
                        
                        let idPaciente = patient["idPaciente"].stringValue
                        let nombre = patient["nombre"].stringValue
                        let email = patient["email"].stringValue
                        let telefono = patient["telefono"].stringValue
                        let nacimiento = patient["nacimiento"].stringValue
                        let genero = patient["genero"].intValue
                        let descripcion = patient["descripcion"].stringValue
                        let nss = patient["nss"].stringValue
                        
                        let gen = Genero.getGenero(gen: genero)
                        
                        let date = APIManager.shared.dateFormatDiaMesAnioSQL().date(from: nacimiento)
                        
                        let patient = Patient.init(idPaciente: idPaciente, nombre: nombre, email: email, telefono: telefono, nacimiento: date ?? Date(), genero: gen, nss: nss, descripcion: descripcion)
                        
                     
                        patients.append(patient)
                    }
                    
                    
                    seal.fulfill(patients)
                    
                    
                } else {
                    os_log("getAllPatients: Error al login error = %{PRIVATE}@",
                           log: OSLog.getData, type: OSLogType.error,
                           String(describing: response.error))
                    seal.reject(NSError(domain: "getAllPatients", code: 0, userInfo: ["msg": errorMessage]))
                }
                
            }
            
            
            
        }
        
        
        
        
    }
    
    func createAppointment(patient: Patient, date: Date, description: String) -> Promise<Bool> {
        
        var errorMessage = "There was a problem creating this appointment, try again"
        
        return Promise {
            seal in
            
            guard let user = APIManager.shared.persistencia.currentUser else {
                seal.reject(NSError(domain: "createAppointment", code: 0, userInfo: ["msg": "Invalid login"]))
                return
            }
            
            let parameters: [String: String] = [
                
                "idPatient"     : patient.idPaciente,
                "idUser"        : user.idUsuario,
                "date"          : APIManager.shared.dateFormatDiaMesAnioHourMinuteSecondSQL().string(from: date),
                "description"   : description
                
                ]
            
            
            
            Alamofire.request(APIURL.luisUrl + "addAppointment.php", parameters: parameters).responseJSON {
                response in
                
                if let data = response.result.value {
                    let jsonData = JSON(data)
                    print("Resultado == \(jsonData)")
                    
                    let status = jsonData["status"].intValue
                    if status != 200 {
                     
                        seal.reject(NSError(domain: "createAppointment", code: 0, userInfo: ["msg": errorMessage]))
                        
                    }
              
                    
                    seal.fulfill(true)
                    
                    
                } else {
                   
                    seal.reject(NSError(domain: "createAppointment", code: 0, userInfo: ["msg": errorMessage]))
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    func getAppointments() -> Promise<[Appointment]>{
        var errorMessage = "Could not get appointments list"
        
        var appointments = [Appointment]()
        
        return Promise {
            seal in
            
            guard let user = APIManager.shared.persistencia.currentUser else {
                seal.reject(NSError(domain: "getAppointments", code: 0, userInfo: ["msg": "Invalid login"]))
                return
            }
            
            let parameters: [String: String] = [
                
                "idUsuario"    : user.idUsuario
                
            ]
            
            Alamofire.request(APIURL.luisUrl + "getAllAppointments.php", parameters: parameters).responseJSON {
                response in
                
                if let data = response.result.value {
                    let jsonData = JSON(data)
                    print("Resultado == \(jsonData)")
                    
                    let status = jsonData["status"].intValue
                    if status != 200 {
                        
                        
                        
                        os_log("getAppointments: Status no fue el esperado = %{PRIVATE}@ mensaje = %{PRIVATE}@",
                               log: OSLog.login, type: OSLogType.error,
                               String(describing: status),
                               String(describing: jsonData["msg"].stringValue))
                        
                        seal.reject(NSError(domain: "getAllPatients", code: 0, userInfo: ["msg": errorMessage]))
                        
                    }
                    
                    let jsonAppointments = jsonData["data"].arrayValue
                    
                    for app in jsonAppointments {
                        
                        let idAppointment = app["idAppointment"].stringValue
                        let idPaciente    = app["idPaciente"].stringValue
                        let date          = app["date"].stringValue
                        let description   = app["description"].stringValue
                        
                        let nombre        = app["nombre"].stringValue
                        let nss           = app["nss"].stringValue
                        
                
                       
                        let realDate = APIManager.shared.dateFormatDiaMesAnioHourMinuteSecondSQL().date(from: date)
                        
                        let appoint = Appointment.init(idAppointment: idAppointment, idPatient: idPaciente, date: realDate ?? Date(), description: description, nombrePaciente: nombre, nssPaciente: nss)
                      
                        
                        appointments.append(appoint)
                    }
                    
                    
                    seal.fulfill(appointments)
                    
                    
                } else {
                    os_log("getAppointments: Error al login error = %{PRIVATE}@",
                           log: OSLog.getData, type: OSLogType.error,
                           String(describing: response.error))
                    seal.reject(NSError(domain: "getAllPatients", code: 0, userInfo: ["msg": errorMessage]))
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
}
