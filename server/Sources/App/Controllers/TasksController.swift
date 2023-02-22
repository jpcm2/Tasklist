//
//  TasksController.swift
//  
//
//  Created by jpcm2 on 22/02/23.
//

import Vapor
import Fluent


struct TasksController: RouteCollection{
    func boot(routes: Vapor.RoutesBuilder) throws {
        //Rotas base
        let mainRoute = routes.grouped("tasks")
        mainRoute.get(use: index)
        mainRoute.post(use: create)
        mainRoute.delete(":taskID", use: delete)
        mainRoute.put(use: updateTask)
        
        //Rotas de Filtragem
        let filterRoute = mainRoute.grouped("filter")
        filterRoute.get(":status", use: getTasksByStatus)
    }
    
    func index(req: Request) async throws -> [Task]{
        let allTasks = try await Task.query(on: req.db).all()
        return allTasks
    }
    
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        let task = try req.content.decode(Task.self)
        return task.save(on: req.db).transform(to: .ok)
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        Task.find(req.parameters.get("taskID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
    
    func updateTask(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let newTask = try req.content.decode(Task.self)
        return Task.find(newTask.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.taskName = newTask.taskName
                $0.priority = newTask.priority
                $0.status = newTask.status
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    func getTasksByStatus(req: Request) async throws -> [Task]{
        let allTasks = try await Task.query(on: req.db).all()
        guard let parameter = req.parameters.get("status") else{
            print("deu erro aqui foi?")
            return []
        }
        let filteredTasks = allTasks.filter{task in
            return task.status == Int(parameter)
        }
        return filteredTasks
    }
}
