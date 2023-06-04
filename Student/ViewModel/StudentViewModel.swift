//
//  StudentListViewModel.swift
//  Student
//
//  Created by TAN PHUC on 04/06/2023.
//

// 1
import Combine

// 2
class StudentViewModel: ObservableObject {
    // 3
    @Published var studentRepository = StudentRepository()
    
    
   
    func get(classId: String)async -> [Student]{
        await   studentRepository.get(classId:classId)
    }
    
    func getAll()async -> [Student]{
        await   studentRepository.getAll()
    }
    
    
    
    func delete(_ studentId: String) {
        studentRepository.delete(studentId)
    }
}

