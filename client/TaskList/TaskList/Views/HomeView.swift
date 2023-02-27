//
//  HomeView.swift
//  TaskList
//
//  Created by jpcm2 on 22/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State var goToDetails: Bool = false
    @State var selectedTask: TaskModel? = nil
    @State var showAddTask: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    ForEach(viewModel.allTasks){task in
                        ListElement(task: task, homeView: self)
                    }
                }
                .background(
                    NavigationLink(destination: AddElementView(), isActive: $showAddTask, label: {EmptyView()})
                )
                .padding()
            }.background(
                NavigationLink(destination: TaskDetailsView(task: self.selectedTask ?? TaskModel(id: UUID(), taskName: "Teste", status: 1, priority: 2)), isActive: $goToDetails, label: {EmptyView()})
            )
            .onAppear{
                Task{
                    do{
                       try await viewModel.fetchAllTasks()
                    }catch
                    {
                        print(error)
                    }
                }
            }
            .navigationTitle("Lista de tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .automatic){
                    Button(action: {
                        self.showAddTask.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
    
    func goToSegue(task: TaskModel){
        self.selectedTask = task
        goToDetails.toggle()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
