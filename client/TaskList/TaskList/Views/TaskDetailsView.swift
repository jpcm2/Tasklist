//
//  TaskDetailsView.swift
//  TaskList
//
//  Created by jpcm2 on 23/02/23.
//

import SwiftUI

struct TaskDetailsView: View {
    let task: TaskModel
    let status = ["Não iniciado", "Em andamento", "Completo"]
    var priorityValue = 1
    init(task: TaskModel) {
        self.task = task
        self.priorityValue = task.priority
    }
    var body: some View {
        VStack(spacing: 32){
            Text(task.taskName)
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text("Situação: ")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(status[task.status])
                    .font(.system(size: 18, weight: .regular))
                Image(systemName: "circle.fill")
                    .foregroundColor(task.status == 0 ? .red : (task.status == 1 ? .yellow : .green))
            }
            
            HStack{
                Text("Prioridade: ")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    ForEach(0..<priorityValue, id: \.self){i in
                        Image(systemName: "star.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            
            Spacer()
            
            VStack(spacing: 12){
                Button(action: {
                    let urlString = "http://127.0.0.1:8080/tasks"
                    
                    guard let url = URL(string: urlString) else{
                        return
                    }
                    
                    let updatedTask = TaskModel(id: task.id, taskName: task.taskName, status: 2, priority: task.priority)
                    Task{
                        try await HTTpClient.shared.sendData(url: url, object: updatedTask, httpMethod: "PUT")
                    }
                }, label: {
                    Text("Marcar como concluída")
                })
                .padding()
                .frame(width: 240)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(14)
                
                Button(action: {
                    let urlString = "http://127.0.0.1:8080/tasks"
                    
                    guard let url = URL(string: urlString) else{
                        return
                    }
                    
                    let updatedTask = TaskModel(id: task.id, taskName: task.taskName, status: 1, priority: task.priority)
                    Task{
                        try await HTTpClient.shared.sendData(url: url, object: updatedTask, httpMethod: "PUT")
                    }
                }, label: {
                    Text("Marcar como iniciada")
                })
                .padding()
                .frame(width: 240)
                .background(.yellow)
                .foregroundColor(.black)
                .cornerRadius(14)
                
                Button(action: {
                    let urlString = "http://127.0.0.1:8080/tasks/\(task.id ?? UUID())"
                    
                    guard let url = URL(string: urlString) else{
                        return
                    }
                    Task{
                        try await HTTpClient.shared.deleteTask(url: url, httpMethod: "DELETE")
                    }
                }, label: {
                    Text("Excluir Task")
                })
                .padding()
                .frame(width: 240)
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(14)
            }
        }.navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(task: TaskModel(id: UUID(), taskName: "Fazer auto layout", status: 2, priority: 4))
    }
}
