//
//  Board.swift
//  chess
//
//  Created by Владислав Жуков on 23.04.2021.
//

import Foundation
import Combine

class Board: ObservableObject {
    @Published var pieces: [Piece] = []
    
    private var cancellable: AnyCancellable?
    private var isWaitingForMove: Bool = false
    
    init(with chess: Chess) {
        pieces = chess.board.keys.compactMap { square in
            Piece(figure: chess.board[square]!.name, index: square.index)
        }
        
        cancellable = $pieces.sink { [weak self] new in
            self?.updateState(with: new)
        }
    }
    
    private func updateState(with pieces: [Piece]) {
        guard !isWaitingForMove else { return }
        print("updateState")
        isWaitingForMove = true
    }
    
    func onNew(with pieces: [Piece]) {
        self.pieces = pieces
        isWaitingForMove = false
    }
}

private extension Chess.Piece {
    var name: String {
        switch type {
        case .pawn: return "pawn_\(color == .white ? "w" : "b")"
        case .rook: return "rook_\(color == .white ? "w" : "b")"
        case .knight: return "knight_\(color == .white ? "w" : "b")"
        case .bishop: return "bishop_\(color == .white ? "w" : "b")"
        case .king: return "king_\(color == .white ? "w" : "b")"
        case .queen: return "queen_\(color == .white ? "w" : "b")"
        }
    }
}

extension Board {
    struct Piece: Identifiable {
        let id = UUID()
        let figure: String
        
        var index: Int
        var isSelect: Bool = false
    }
}

extension Board.Piece {
    var row: Int { index / 8 }
    var column: Int { index % 8 }
}

/*

 { command: Move, data: { id: "", from: 12, to: 23 } }

*/
class WebSocket {
    private func msgHandler(_ msg: URLSessionWebSocketTask.Message) {
        guard case .string(let text) = msg else {
            NSLog("error with type socket message")
            return
        }
        guard let data = text.toDictionary else { return }
        guard let command = data["command"] as? String else {
            NSLog("error with parsing event -> \(text)")
            return
        }
         
        switch command {
        case "move":
            NSLog("socket was successfully connected")

        default: NSLog("we got unsupported socket message -> \(text)")
        }
        
    }
}

extension String {
    var toDictionary: [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                NSLog(error.localizedDescription)
            }
        }
        return nil
    }
}

extension WebSocket {
    enum Command: String {
        case move
    }
}

struct SocketCommand: Codable {
    let command: String
    let data: String
}

extension String {
    var toCommand: SocketCommand? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try JSONDecoder().decode(SocketCommand.self, from: data)
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
}
