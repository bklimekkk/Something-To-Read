//
//  Something_To_ReadApp.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import SwiftUI
import CoreData

@main
struct Something_To_ReadApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
