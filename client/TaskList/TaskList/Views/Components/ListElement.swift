//
//  ListElement.swift
//  TaskList
//
//  Created by jpcm2 on 22/02/23.
//

import SwiftUI

struct ListElement: View {
    let status = ["Não iniciado", "Em andamento", "Completo"]
    let task: TaskModel
    let homeView: HomeView
    
    var body: some View {
        HStack{
            Text(task.taskName)
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: 200, alignment: .leading)
            Spacer()
            HStack(){
                Text(status[task.status])
                    .font(.system(size: 16, weight: .light))
                    .frame(maxWidth: 200, alignment: .trailing)
                Image(systemName: "circle.fill")
                    .foregroundColor(task.status == 0 ? .red : (task.status == 1 ? .yellow : .green))
                Image(systemName: "arrow.right")
                    .foregroundColor(.gray)
            }
        }.onTapGesture {
            homeView.goToSegue(task: task)
        }
        .padding([.top, .bottom], 16)
    }
}

struct ListElement_Previews: PreviewProvider {
    static var previews: some View {
        ListElement(task: TaskModel(id: UUID(), taskName: "Fazer auto layout", status: 2, priority: 1), homeView: HomeView())
    }
}
