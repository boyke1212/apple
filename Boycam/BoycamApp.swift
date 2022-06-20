//
//  BoycamApp.swift
//  Boycam
//
//  Created by USER on 18/06/22.
//

import SwiftUI

@main
struct BoycamApp: App {
    @StateObject private var pengontrolData = PengontrolData()
    let boyprefs = UserDefaults.standard
    var savelogin:Bool=false
    init(){
        savelogin=boyprefs.bool(forKey: "savelogin")
    }
    var body: some Scene {
        
        WindowGroup {
            if(savelogin){
                
                Home()
                    .environment(\.managedObjectContext, pengontrolData.wadah.viewContext)
                   
            }else{
                ContentView()
                    .environment(\.managedObjectContext, pengontrolData.wadah.viewContext)
              
             
            }
          
        }
    }
}


    
   
    

