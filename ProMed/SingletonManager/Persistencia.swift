//
//  Persistencia.swift
//  ProMed
//
//  Created by Luis Luna on 2/21/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
import RealmSwift
final class Persistencia {
    var currentUser: Professional?
    
    private var realm: Realm?
    
    
    func realmBD() -> Realm? {
        if APIManager.shared.persistencia.realm == nil {
            print("Realm es nil, se creara ahora...")
            
            
            let config = Realm.Configuration(
                encryptionKey: getKey() as Data,
                schemaVersion: 4,
                migrationBlock: { migration, oldSchemaVersion in
                    
                    if oldSchemaVersion < 1 {
                        print("Actualizando Schema !!!!")
                        
                    }
                    
            }
                
            )
            
            
            do {
                APIManager.shared.persistencia.realm = try Realm(configuration: config)
                
            } catch  {
                print("Ocurrio un error: \(error)")
            }
            
        } else {
            //print("Ya existe realm")
        }
        return APIManager.shared.persistencia.realm
    }
    
    private func getKey() -> NSData {
        print("Obteniendo llave realm")
        // Identificador para el llavero unico
        let keychainIdentifier = "com.promed.local"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // Verificar si la entrada ya existe en el llavero
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        //Obtener el objeto del llavero usando unsafeMutablePointer para mejorar el performance
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            print("LLave en llavero")
            return dataTypeRef as! NSData
        }
        
        // No existe llave en el llavero asi que se genera una nueva
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Error al obtener bytes aleatorios")
        
        // Se guarda esta llave en el llavero
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Error al insertar nueva llave en el llavero.")
        print("llave agregada a llavero")
        return keyData
        
        
    }
   
    
    
}
