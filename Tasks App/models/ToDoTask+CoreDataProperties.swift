//
//  ToDoTask+CoreDataProperties.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var title: String?
    @NSManaged public var completionDate: NSDate?
    @NSManaged public var taskCategory: TaskCategory?

}
