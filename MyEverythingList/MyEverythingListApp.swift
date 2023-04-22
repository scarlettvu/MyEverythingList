//
//  MyEverythingListApp.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
@main
struct MyEverythingListApp: App {
    @StateObject var signInViewModel = FirebaseFunctions()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            ContentView()
            HomePageView()
                .environmentObject(signInViewModel)
        }
    }
}

