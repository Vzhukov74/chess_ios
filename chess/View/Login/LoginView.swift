//
//  LoginView.swift
//  chess
//
//  Created by Владислав Жуков on 27.04.2021.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    var body: some View {
        SignInWithApple()
          .frame(width: 280, height: 60)
          .onTapGesture(perform: showAppleLogin)
    }
    
    private func showAppleLogin() {
        //let request = ASAuthorizationAppleIDProvider().createRequest()
        //request.requestedScopes = [.fullName]
        //let controller = ASAuthorizationController(authorizationRequests: [request])
    }
}


private final class SignInWithApple: UIViewRepresentable {

  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    return ASAuthorizationAppleIDButton()
  }
  
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
