//
//  stukApp.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-02.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func getOrCreateUniqueID() -> String {
        let defaults = UserDefaults.standard
        let id = defaults.string(forKey: "uid")
        
        if let id = id {
            return id
        } else {
            let newID = UIDevice.current.identifierForVendor?.uuidString
            defaults.set(newID, forKey: "uid")
            return newID!
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        let db = Firestore.firestore()
        let userID = getOrCreateUniqueID()
        
        let personnummer = UserDefaults.standard.string(forKey: "personnummer")
        
        if let personnummer = personnummer {
            
            let userRef = db.collection("users").document(personnummer)
            
            userRef.getDocument { document, error in
                if let document = document, document.exists, let data = document.data(), let disabled = data["disabled"] as? Bool, disabled {
                    fatalError("This device has been disabled. Exiting...")
                }
            }
        }
                
        return true
    }
}

@main
struct stukApp: App {
    @State private var path = NavigationPath()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear {
                    let defaults = UserDefaults.standard
                    
                    let fp = defaults.double(forKey: "firstPadding")
                    Shared.shared.firstPadding = CGFloat(fp)
                    
                    let sp = defaults.double(forKey: "secondPadding")
                    Shared.shared.secondPadding = CGFloat(sp)
                    
                    let name = defaults.string(forKey: "name")
                    Shared.shared.name = name ?? "namn efternamn"
                    
                    let personNbr = defaults.string(forKey: "personnummer")
                    Shared.shared.personNbr = personNbr ?? "DDMMYY-xxxx"
                    
                    let email = defaults.string(forKey: "mail")
                    Shared.shared.email = email ?? "x@y.se"
                    
                    let initials = defaults.string(forKey: "intials")
                    Shared.shared.initials = initials ?? "KD"
                    
                    let isBigLangs = defaults.bool(forKey: "isBigLangs")
                    Shared.shared.isLangs = isBigLangs
                    
                }
        }
    }
}
