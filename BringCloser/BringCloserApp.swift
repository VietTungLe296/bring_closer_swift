//
//  BringCloserApp.swift
//  BringCloser
//
//  Created by Le Viet Tung on 20/06/2023.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
