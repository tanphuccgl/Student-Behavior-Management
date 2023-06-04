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
class ClassRepository: ObservableObject {
    
    private let path: String = "class"
    
    private let store = Firestore.firestore()
    


    func get() async -> [ClassModel]{
        do {
            var list = [ClassModel]()
            
            // .whereField("capital", isEqualTo: true)
            let snapshot = try await store.collection(path).getDocuments()
            
            snapshot.documents.forEach {
                documentSnapshot in
                let documentData = documentSnapshot.data()
                
                
                let id = documentData["id"] as? String ?? ""
                let name = documentData["name"] as? String ?? ""
                
                
                
                list.append(ClassModel(id: id, name: name)!)
                

            }
       
            
        
            return list;
            
        } catch {
            fatalError("Unable to add student: \(error.localizedDescription).")
            return [];
        }
    }
}


