//
//  BookTrackerApp.swift
//  BookTracker
//
//  Created by Kunal More on 15/04/24.
//

import SwiftUI
import SwiftData

@main
struct BookTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
}
