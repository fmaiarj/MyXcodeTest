//
//  Prefs.swift
//  Carros
//
//  Created by Luiz Felipe Oliveira Maia on 02/02/17.
//  Copyright © 2017 Ricardo Lecheta. All rights reserved.
//

import Foundation


class Prefs {
    
    class func setString(valor:String, chave:String) {
        
        let prefs = UserDefaults.standard
        prefs.setValue(valor, forKey: chave)
        prefs.synchronize()
        
    }
    
    
    class func getString(chave:String) -> String! {
        
        let prefs = UserDefaults.standard
        let s = prefs.string(forKey: chave)
        return s
        
    }
    
    class func setInt(valor:Int, chave:String) {
        
        let prefs = UserDefaults.standard
        prefs.set(valor, forKey: chave)
        prefs.synchronize()
        
    }
    
    class func getValue(chave:String) -> Int {
        
        let prefs = UserDefaults.standard
        let s = prefs.integer(forKey: chave)
        return s
        
    }
    
    
}
