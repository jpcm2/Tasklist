//
//  TaskModel.swift
//  TaskList
//
//  Created by jpcm2 on 22/02/23.
//

import SwiftUI

struct TaskModel: Identifiable, Codable{
    let id: UUID?
    var taskName: String
    var status: Int
    var priority: Int
}
