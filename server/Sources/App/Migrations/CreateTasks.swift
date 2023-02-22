//
//  CreateTasks.swift
//  
//
//  Created by jpcm2 on 22/02/23.
//

import Fluent

struct CreateTasks: AsyncMigration{
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("tasks")
            .id()
            .field("taskName", .string, .required)
            .field("status", .int, .required)
            .field("priority", .int, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("tasks").delete()
    }
}
