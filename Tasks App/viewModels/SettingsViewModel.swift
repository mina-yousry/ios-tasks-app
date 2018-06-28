//
//  SettingsViewModel.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class SettingsViewModel: NSObject {

    func addCategory(name: String, color: String) {
        var addedCategory = TaskCategory(context: PersistenceUtility.context)
        addedCategory.name = name
        addedCategory.color = color
        PersistenceUtility.saveContext()
    }
}
