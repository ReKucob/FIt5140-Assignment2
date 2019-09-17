//
//  FirebaseController.swift
//  FIt5140-Assignment2
//
//  Created by Burns on 12/9/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseController: NSObject, DatabaseProtocol {
    
    var listener = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database:Firestore
    var barometricRef: CollectionReference?

    
    override init() {
        authController = Auth.auth()
        database = Firestore.firestore()
        
        
        super.init()
        
        authController.signInAnonymously(){(authResult,error) in
            guard authResult != nil else{
                fatalError("Firebase athentication faileds")
            }
            
            self.setUpListeners()
            
        }
        
    }
    
    
    func setUpListeners(){
        
    }
    
    
}
