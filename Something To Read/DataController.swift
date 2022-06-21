//
//  DataController.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    var container = NSPersistentContainer(name: "ReadingList")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
