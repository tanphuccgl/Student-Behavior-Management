//
//  CardRepository.swift
//  Student
//
//  Created by TAN PHUC on 04/06/2023.
//

// 1
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

// 2
class AccountRepository: ObservableObject {
    // 3
    private let path: String = "account"
    // 4
    private let store = Firestore.firestore()
    

    func get() async -> Bool{
        do {
           
       
            
        
            return true;
            
        } catch {
            fatalError("Unable to add account: \(error.localizedDescription).")
            return false;
        }
    }
}


