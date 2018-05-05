//
//  Configuration.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case iof = "iof"
    case dollar = "dollar"
}

class Configuration {
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var dollar: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.dollar.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.dollar.rawValue)
        }
    }
    
    var iof: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.iof.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.iof.rawValue)
        }
    }
    
    private init(){
        
    }
}

