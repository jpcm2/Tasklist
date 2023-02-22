//
//  Task.swift
//  
//
//  Created by jpcm2 on 22/02/23.
//

import Vapor
import Fluent


final class Task: Model, Content{
    static var schema: String = "tasks"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "taskName")
    var taskName: String
    
    @Field(key: "status")
    var status: Int
    
    @Field(key: "priority")
    var priority: Int
    
    init(){}
    
    init(id: UUID? = nil, taskName: String, status: Int, priority: Int) {
        self.id = id
        self.taskName = taskName
        self.status = status
        self.priority = priority
    }
}
