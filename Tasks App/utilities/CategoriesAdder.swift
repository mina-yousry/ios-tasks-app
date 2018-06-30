//
//  CategoriesAdder.swift
//  Tasks App
//
//  Created by Admin on 6/30/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class CategoriesAdder: NSObject {

    //this method is used to add a new category
    func addNewCategory(name: String, color: String) {
        let addedCategory = TaskCategory(context: PersistenceUtility.context)
        addedCategory.name = name
        addedCategory.color = color
        PersistenceUtility.saveContext()
    }
}
