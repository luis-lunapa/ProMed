//
//  Professional.swift
//  ProMed
//
//  Created by Luis Luna on 2/21/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
class Professional {
    
    var name: String
    
    lazy var recentPatients = [Patient]()
    
    
    init (name: String) {
        self.name = name
    }
    
    
    
}
