//
//  SettingsViewModel.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class SettingsViewModel: NSObject {
    
    @IBOutlet var categoriesAdder: CategoriesAdder!

    func addCategory(name: String, color: String) {
        categoriesAdder.addNewCategory(name: name, color: color)
    }
    
    
}
