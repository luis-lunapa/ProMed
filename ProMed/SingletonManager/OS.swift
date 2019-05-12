//
//  OS.swift
//  ProMed
//
//  Created by Luis Luna on 5/12/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
import os

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let login = OSLog(subsystem: subsystem, category: "login")
    static let getData = OSLog(subsystem: subsystem, category: "getData")
}
