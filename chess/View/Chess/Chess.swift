//
//  Chess.swift
//  chess
//
//  Created by Владислав Жуков on 23.04.2021.
//

import Foundation

struct Chess {
    var board: [Square: Piece]
}

extension Chess {
    private static let size: Int = 8
    
    struct Square: Hashable {
        let index: Int
        
        var row: Int { index / Chess.size }
        var column: Int { index % Chess.size }
    }
    
    struct Piece {
        let type: PieceType
        let color: Color
    }
    
    enum Color {
        case black, white
    }
    
    enum PieceType {
        case pawn, rook, knight, bishop, queen, king
    }
}

extension Chess {
    static var inition: Chess = Chess(board: [
        //Black
        Square(index: 0): Piece(type: .rook, color: .black),
        Square(index: 1): Piece(type: .knight, color: .black),
        Square(index: 2): Piece(type: .bishop, color: .black),
        Square(index: 3): Piece(type: .knight, color: .black),
        Square(index: 4): Piece(type: .queen, color: .black),
        Square(index: 5): Piece(type: .bishop, color: .black),
        Square(index: 6): Piece(type: .knight, color: .black),
        Square(index: 7): Piece(type: .rook, color: .black),
        
        Square(index: 8): Piece(type: .pawn, color: .black),
        Square(index: 9): Piece(type: .pawn, color: .black),
        Square(index: 10): Piece(type: .pawn, color: .black),
        Square(index: 11): Piece(type: .pawn, color: .black),
        Square(index: 12): Piece(type: .pawn, color: .black),
        Square(index: 13): Piece(type: .pawn, color: .black),
        Square(index: 14): Piece(type: .pawn, color: .black),
        Square(index: 15): Piece(type: .pawn, color: .black),
        //White
        Square(index: 48): Piece(type: .pawn, color: .white),
        Square(index: 49): Piece(type: .pawn, color: .white),
        Square(index: 50): Piece(type: .pawn, color: .white),
        Square(index: 51): Piece(type: .pawn, color: .white),
        Square(index: 52): Piece(type: .pawn, color: .white),
        Square(index: 53): Piece(type: .pawn, color: .white),
        Square(index: 54): Piece(type: .pawn, color: .white),
        Square(index: 55): Piece(type: .pawn, color: .white),
        
        Square(index: 56): Piece(type: .rook, color: .white),
        Square(index: 57): Piece(type: .knight, color: .white),
        Square(index: 58): Piece(type: .bishop, color: .white),
        Square(index: 59): Piece(type: .knight, color: .white),
        Square(index: 60): Piece(type: .queen, color: .white),
        Square(index: 61): Piece(type: .bishop, color: .white),
        Square(index: 62): Piece(type: .knight, color: .white),
        Square(index: 63): Piece(type: .rook, color: .white)
    ])
}
