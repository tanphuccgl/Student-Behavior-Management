//
//  StudentListViewModel.swift
//  Student
//
//  Created by TAN PHUC on 04/06/2023.
//

// 1
import Combine

// 2
class ClassViewModel: ObservableObject {
    // 3
    @Published var classRepository = ClassRepository()
    
    func get()async -> [ClassModel]{
        await   classRepository.get()
    }
   
}

