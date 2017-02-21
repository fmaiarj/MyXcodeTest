//
//  SQLiteHelper.swift
//  Carros
//
//  Created by Luiz Felipe Oliveira Maia on 21/02/17.
//  Copyright © 2017 Ricardo Lecheta. All rights reserved.
//

import Foundation

class SQLiteHelper : NSObject {
    
    //sqllite3 *db
    
    var db: OpaquePointer? = nil;
    
    //Construtor
    
    init(database: String){
        
        super.init()
        self.db =  open(database)
        
    }
    
    //Caminho banco de dados
    
    func getFilePath(nome: String) -> String {
        
        //Caminho com o arquivo
        
        let path = NSHomeDirector + "/Documents/" + nome
        
        print("Database: " + path)
        
        return path
        
    }
    
    
    //Abre o banco de dados
    
    func open(database: String) -> OpaquePointer {
        
        var db: OpaquePointer? = nil;
        let path = getFilePath(nome: database)
        let cPath = StringUtils.toCString(path)
        let result = sqlite3_open(cPath, &db)
        if(result == SQLITE_ERROR){
            print("Erro ao abrir banco de dados")
            }
        
        return db
    }
    
    //Executa SQL
    
    
    func execSql(sql:String) -> CInt {
        
        return self.execSql(sql: sql, params: nil)
        
    }
    
    
    func execSql(sql: String, params: Array<AnyObject>!) -> CInt {
        
        //Statement
        let smtm = query(sql,prarams: params)
        
        //Step
        
        var result = sqlite3_step(stmt)
        if result != SQLITE_OK && result != SQLITE_DONE {
            sqlite_finalize(smtm)
            let msg = "Erro ao executar SQL \n\(sql)\nError: \(lastSQLError())"
            print(msg)
            retunr -1
        }
     
        if sql.uppercaseString.hasPrefix("INSERT") {
            //http://www.sqlite.org/c3ref/last_insert_rowid.html
   
            let rid = sqlite3_last_insert_rowid(self.db)
            result = Cint(rid)
        }else{
            result = -1
        }
        
        //Fecha o statment
        sqlite3_finalize(stmt)
        return result
        
    }
    
    // Faz o bind dos parametros (?,?,?) de um SQL
    
    func bindParams(smtm: OpaquePointer, params:Array<AnyObject>!) {
        
        if(params != nil) {
            
            let size  = params.count
            
            for i:Int int 1..size {
                let value:AnyObject = params[i-1]
                if(value is Int){
                    let number:Cint = toCint(value as! Int)
                    sqlite3_bind_int(smtm, idx: toCint(i), withString: text)
                }
            }
        }
        
    }
    
    //Executa o SQL e retorna o Statement (stmt)
    
    func query(sql: String) -> OpaquePointer {
        
    }
    
    func query(sql: String, params: Array<AnyObject>) {
        
        var stmt: OpaquePointer? = nil;
        let cSql = StringUtils.toCString(sql)
        
        //prepare
        let result = sqlite3_prepare_v2(self.db, cSql, -1, &stmt, nil)
        
        if result != SQLITE_OK {
            
            sqlite3_finalize(stmt)
            
            let msg = "Erro ao preparar SQL\n\(sql)\nErro: \(lastSQLError())"
            print("SQLite ERROR \(msg)")
            
        }
        
        //Bind Values(?,?,?)
        if(params != nil) {
            bindParams(smtm: stmt, params: params)
        }
        
        return stmt
    }
    
    // Retorna true se existe a próxima linha da consulta 
    func nextRow(stmt:OpaquePointer) -> Bool {
        let result = sqlite3_step(stmt)
        let next: Bool = result == SQLITE_ROW
        return next
    }

    
    // Fecha o statement
    func closeStatement(stmt:OpaquePointer) {
        sqlite3_finalize(stmt)
    }
    
    // Fecha o Banco de dados
    
    func close() {
    
        sqlite3_close(self.db)
    }
    
    // Retorna ultimo erro de SQL
    
    func lastSQLError() -> String {
        
        var err:UnsafePointer<int8>? = nil
        err = sqlite3_errmsg(self.db)
        if(err != nil) {
            let s = NSString(utf8String: err!)
            return s as! String
        }
        
        return ""
        
    }
    
    // Lê uma coluna do tipo Int
    
    func getInt(stmt:OpaquePointer, index: CInt) -> Int {
        
        let val = sqlite3_column_int(stmt, index)
        return Int(val)
        
    }
    
    // Lê uma coluna do tipo Double
    
    func getDouble(stmt: OpaquePointer, index: CInt) -> Double {
        
        let val = sqlite3_column_double(stmt, index)
        return Double(val)
        
    }

    func getFloat(stmt: OpaquePointer, index: CInt) -> Float {
        
        let val = sqlite3_column_double(stmt, index)
        return Float(val)
        
    }
    
    // Lê uma coluna do tipo String
    
    func getString(stmt: OpaquePointer, index:CInt) -> String {
        
        let cString = SQLiteObjec.getText(stmt, idx: index)
        let s = String(cString)
        return s
    }
    
    // Converte Int (Swift) para CInt(C)
    
    func toCInt(swiftInt: Int) -> CInt {
        
        let number : NSNumber = swiftInt as NSNumber
        let pos: CInt = number.intValue
        return pos
    }

    
    
    
}





