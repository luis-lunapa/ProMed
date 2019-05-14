//
//  APIManager.swift
//  ProMed
//
//  Created by Luis Luna on 2/21/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation

final class APIManager {
    private init (){}
    
    
    static let shared = APIManager()
    let persistencia = Persistencia()
    let networking: Networking = Networking()
    
    func dateFormatDiaMesAnio() -> DateFormatter {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        
        return dateFormatter
    }
    
    func dateFormatDiaMesAnioSQL() -> DateFormatter {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        return dateFormatter
    }
    
   
    func dateFormatDiaMesAnioHourMinuteSecondSQL() -> DateFormatter {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        
        
        return dateFormatter
    }
    
    func dateFormatHMS() -> DateFormatter {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:SS"
        
        
        return dateFormatter
    }
    
    
}
