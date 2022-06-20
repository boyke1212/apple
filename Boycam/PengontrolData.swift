//
//  PengontrolData.swift
//  Boycam
//
//  Created by USER on 19/06/22.
//

import Foundation
import CoreData

class PengontrolData:ObservableObject{
    let wadah=NSPersistentContainer(name: "CoreModel")
    
    init(){
        wadah.loadPersistentStores{description,error in
            if let error=error{
                print("Core Data Failed to Load\(error.localizedDescription)")
            }
        }
            
    }
}
