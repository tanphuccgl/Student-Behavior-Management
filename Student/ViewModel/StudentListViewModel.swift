//
//  StudentListViewModel.swift
//  Student
//
//  Created by TAN PHUC on 04/06/2023.
//

// 1
import Combine

// 2
class StudentListViewModel: ObservableObject {
    // 3
    @Published var studentListRepository = StudentListRepository()
    
    
    // 4
    func add(_ student: Student) {
        studentListRepository.add(student)
    }
    
    func get(classId: String)async -> [Student]{
        await   studentListRepository.get(classId:classId)
    }
    
    func getInfo(studentId: String)async -> Student?{
        await   studentListRepository.getInfo(studentId:studentId)
    }
    
    func getAll()async -> [Student]{
        await   studentListRepository.getAll()
    }
    
    
    
    func delete(_ studentId: String) {
        studentListRepository.delete(studentId)
    }
    func update(_ student: Student) {
        studentListRepository.update(student)
    }
    
}

