//
//  chessApp.swift
//  chess
//
//  Created by Владислав Жуков on 22.04.2021.
//

import SwiftUI

@main
struct chessApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
                //GameListView(list: GameList())
            }
            
            //BoardView(model: Board(with: Chess.inition))
        }
    }
}
