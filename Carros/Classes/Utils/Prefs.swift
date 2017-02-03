//
//  Prefs.swift
//  Carros
//
//  Created by Luiz Felipe Oliveira Maia on 02/02/17.
//  Copyright © 2017 Ricardo Lecheta. All rights reserved.
//

import Foundation


class Prefs {
    
    
    class func getFilePath(nome: String) -> String {
        
        //Caminho com o arquivo
        
        let path = NSHomeDirectory() + "/Documents/" + nome + ".txt"
        
        print("path:: -> " + path)
        
        return path
        
    }
    
    class func setString(valor:String, chave:String) {
        
        // Usando Arquivos pra gravar dados
        
        // Caminho com arquivo
        let path = Prefs.getFilePath(nome: chave)
        let nsdata = StringUtils.toNSData(valor)
        
        // Escreve o NSdata para o arquivo
        
        do{
            
            try nsdata.write(to: URL(fileURLWithPath: path))
            
        }catch{
            
            print(error)
        }
        
        // Usando NSUserDefaults
        
        if(false) {
        let prefs = UserDefaults.standard
        prefs.setValue(valor, forKey: chave)
        prefs.synchronize()
        }
        
    }
    
    
    class func getString(chave:String) -> String! {
        
        // Caminho com arquivo
        
        let path = Prefs.getFilePath(nome: chave)
        let nsdata = NSData(contentsOfFile: path)
        let data = nsdata as Data!
        let valor = StringUtils.toString(data)
        
        return valor
        
        // Usando NSUserDefaults (UserDefaults Class)
        
        if(false) {
        let prefs = UserDefaults.standard
        let s = prefs.string(forKey: chave)
        return s
        }
        
    }
    
    class func setInt(valor:Int, chave:String) {
        
        
        setString(valor: String(valor), chave: chave)
        
        
        // Usando NSUSerDefaults (UserDefaults Class)
        
        if(false) {
        let prefs = UserDefaults.standard
        prefs.set(valor, forKey: chave)
        prefs.synchronize()
        }
    }
    
    class func getInt(chave:String) -> Int {
        
        let valorString: String! = getString(chave: chave)
        
        if(valorString == nil) {
            
            // Não existe
            return 0
        }
        
        let valorInt = Int(valorString)
    
        return valorInt!
        
        // Usando NSUserDefaults (UserDefaults Class)
        
        if(false) {
        let prefs = UserDefaults.standard
        let s = prefs.integer(forKey: chave)
        return s
        }
    }
    
    
}
