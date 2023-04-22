//
//  SignInView.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Foundation
import UIKit
import FirebaseAuth
struct AuthDataResultModel {
    let uid: String
    init(user: User) {
        self.uid = user.uid
    }
}
struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String

}
@MainActor
final class AuthenticaionVM: ObservableObject {
        @MainActor
        func signInGoogle() async throws {
            guard let topVC = Utilities.shared.topViewController() else {
                throw URLError(.cannotFindHost)
            }
            let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
            guard let idToken = gidSignInResult.user.idToken?.tokenString else {
                throw URLError(.badServerResponse)
            }
            let accessToken = gidSignInResult.user.accessToken.tokenString
            let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
            try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        }
}
struct SignInView: View {
    @Binding var showview :Bool
    @StateObject private var viewModel = AuthenticaionVM()
    var body: some View {
        VStack {

            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task{
                    do{
                        try await viewModel.signInGoogle()
                        showview = false
                        
                        print("signInGoogle")
                    }catch{
                        
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(showview: .constant(false))
    }
}
