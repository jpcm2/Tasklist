//
//  AddElementView.swift
//  TaskList
//
//  Created by jpcm2 on 23/02/23.
//

import SwiftUI

struct AddElementView: View {
    
    @State private var taskName: String = ""
    var prioridades = [1, 2, 3, 4, 5]
    @State private var selectedPriority = 1
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing: 48){
            VStack(spacing: 16){
                Text("Escreva o título da tarefa")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Implementar autenticação", text: $taskName)
            }
            
            VStack(spacing: 16){
                Text("Prioridade da Tarefa")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("Selecione a prioridade (1 - 5)", selection: $selectedPriority){
                    ForEach(prioridades, id: \.self){val in
                        Text("\(val)")
                    }
                }
            }
            Spacer()
            
            Button(action: {
                let newTask = TaskModel(id: nil, taskName: taskName, status: 0, priority: selectedPriority)
                let urlString = "http://127.0.0.1:8080/tasks"
                print(urlString)
                guard let url = URL(string: urlString) else{
                    return
                }
                
                Task{
                    try await HTTpClient.shared.sendData(url: url, object: newTask, httpMethod: "POST")
                }
                
                taskName = ""
                selectedPriority = 1
                showAlert.toggle()
            }, label: {
                Text("Adicionar Tarefa")
            })
            .padding(24)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(16)
            .alert("Tarefa adicionada com sucesso", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
            }
        }
        .padding()
        .navigationTitle("Adicionar tarefa")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddElementView_Previews: PreviewProvider {
    static var previews: some View {
        AddElementView()
    }
}
