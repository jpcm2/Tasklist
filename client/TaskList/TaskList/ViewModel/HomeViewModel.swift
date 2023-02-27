//
//  HomeViewModel.swift
//  TaskList
//
//  Created by jpcm2 on 22/02/23.
//

import SwiftUI


class HomeViewModel: ObservableObject{
    
    @Published var allTasks = [TaskModel]()
    
    func fetchAllTasks() async throws {
        let urlString = "http://127.0.0.1:8080/tasks"
        guard let url = URL(string: urlString)else{
            print("deu ruim na fetch de all tasks")
            return
        }
        let tasksResponse: [TaskModel] = try await HTTpClient.shared.fetch(url: url)
        
        print(tasksResponse)
        DispatchQueue.main.async {
            self.allTasks = tasksResponse
        }
    }
}
