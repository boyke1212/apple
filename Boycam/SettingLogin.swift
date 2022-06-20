//
//  SettingLogin.swift
//  Boycam
//
//  Created by USER on 18/06/22.
//

import Foundation
import Combine

class SettingLogin: ObservableObject {
    @Published var savelogin: String {
        didSet {
            UserDefaults.standard.set("login", forKey: "savelogin")
        }
    }
    
    init() {
        self.savelogin = UserDefaults.standard.object(forKey: "savelogin") as? String ?? ""
    }
}
