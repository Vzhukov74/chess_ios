//
//  GameList.swift
//  chess
//
//  Created by Владислав Жуков on 27.04.2021.
//

import SwiftUI

struct Game: Identifiable {
    let id: UUID = UUID()
    let title = "Some game"
}

class GameList: ObservableObject {
    @Published private(set) var items: [Game] = Array(repeating: Game(), count: 10)
    @Published private(set) var isLoading: Bool = false
    
    
    
    func fetch() {
//        guard isLoading == false else { return }
//
//        isLoading = true
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.isLoading = false
//            self.items = Array(repeating: Game(), count: 10)
//        }
    }
}

struct GameListView: View {
    @ObservedObject var list: GameList
    @State private var isShowCreateNewGameView: Bool = false
    
    var body: some View {
        List() {
            if list.isLoading {
                HStack {
                    Spacer(minLength: 0)
                    ProgressView()
                    Spacer(minLength: 0)
                }
            }
            
            ForEach(list.items) { item in
                NavigationLink(destination: BoardView(model: Board(with: Chess.inition))) {
                    GameListItemView(item: item)
                }
            }
        }
        .onAppear { list.fetch() }
        .navigationTitle("Games")
        .navigationBarItems(trailing: Button(action: {isShowCreateNewGameView = true}, label: {Image(systemName: "plus")}))
        .sheet(isPresented: $isShowCreateNewGameView) {
            CreateGameView(isShow: $isShowCreateNewGameView)
        }
    }
}

private struct GameListItemView: View {
    let item: Game
    
    var body: some View {
        VStack {
            Text(item.title)
        }
    }
}

struct CreateGameView: View {
    @Binding var isShow: Bool
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text("Game title:")
            TextField("", text: $text)
            Button {
                isShow = false
            } label: { Text("Create") }
            .disabled(text.isEmpty)
            Spacer(minLength: 0)
        }
    }
}
