//
//  WeeklyKakeiboApp.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/10/17.
//

import SwiftUI

@main
struct WeeklyKakeiboApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
