//
//  BoardView.swift
//  chess
//
//  Created by Владислав Жуков on 22.04.2021.
//

import SwiftUI

extension Color {
    static let whiteSquare = Color("whiteSquare")
    static let blackSquare = Color("blackSquare")
}

struct Piece: Identifiable {
    let id = UUID()
    var isSelect: Bool = false
    var index: Int
    var imageName: String
}



extension Piece {
    static let inition: [Piece] = {
        var inition: [Piece] = []
        
        inition.append(Piece(index: 0, imageName: "rook_b"))
        inition.append(Piece(index: 1, imageName: "knight_b"))
        inition.append(Piece(index: 2, imageName: "bishop_b"))
        inition.append(Piece(index: 3, imageName: "king_b"))
        inition.append(Piece(index: 4, imageName: "queen_b"))
        inition.append(Piece(index: 5, imageName: "bishop_b"))
        inition.append(Piece(index: 6, imageName: "knight_b"))
        inition.append(Piece(index: 7, imageName: "rook_b"))
        
        inition.append(Piece(index: 8, imageName: "pawn_b"))
        inition.append(Piece(index: 9, imageName: "pawn_b"))
        inition.append(Piece(index: 10, imageName: "pawn_b"))
        inition.append(Piece(index: 11, imageName: "pawn_b"))
        inition.append(Piece(index: 12, imageName: "pawn_b"))
        inition.append(Piece(index: 13, imageName: "pawn_b"))
        inition.append(Piece(index: 14, imageName: "pawn_b"))
        inition.append(Piece(index: 15, imageName: "pawn_b"))
        
        inition.append(Piece(index: 48, imageName: "pawn_w"))
        inition.append(Piece(index: 49, imageName: "pawn_w"))
        inition.append(Piece(index: 50, imageName: "pawn_w"))
        inition.append(Piece(index: 51, imageName: "pawn_w"))
        inition.append(Piece(index: 52, imageName: "pawn_w"))
        inition.append(Piece(index: 53, imageName: "pawn_w"))
        inition.append(Piece(index: 54, imageName: "pawn_w"))
        inition.append(Piece(index: 55, imageName: "pawn_w"))
        
        inition.append(Piece(index: 56, imageName: "rook_w"))
        inition.append(Piece(index: 57, imageName: "knight_w"))
        inition.append(Piece(index: 58, imageName: "bishop_w"))
        inition.append(Piece(index: 59, imageName: "king_w"))
        inition.append(Piece(index: 60, imageName: "queen_w"))
        inition.append(Piece(index: 61, imageName: "bishop_w"))
        inition.append(Piece(index: 62, imageName: "knight_w"))
        inition.append(Piece(index: 63, imageName: "rook_w"))
                
        return inition
    }()
}

struct BoardView: View {
    @State var pieces: [Piece] = Piece.inition
    @State var dragPosition: CGPoint = .zero
    
    let abc = ["a", "b", "c", "d", "e", "f", "g", "h"]
    let num = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                
            }
            .onEnded { value in
                
            }
    }
    
    var body: some View {
        GeometryReader { g in
            let squareSideSize = g.size.width / 10
            
            VStack(spacing: 0) {
                BoardLettersView()
                    .frame(height: squareSideSize)
                
                HStack(spacing: 0) {
                    BoardNumbersView()
                        .frame(width: squareSideSize)
                    GeometryReader { geo in
                        let squareSideSize = geo.size.width / 8
                        ZStack {
                            self.squares(with: squareSideSize)
                            self.chessPieces(with: squareSideSize)
                        }
                    }
                        .frame(width: squareSideSize * 8, height: squareSideSize * 8)
                    BoardNumbersView()
                        .frame(width: squareSideSize)
                }
                
                BoardLettersView()
                    .frame(height: squareSideSize)
            }
            
            
            

        }
            .aspectRatio(1, contentMode: .fit)
    }
    
    @ViewBuilder
    private func squares(with width: CGFloat) -> some View {
        ForEach(0..<8) { row in
            ForEach(0..<8) { column in
                let isWhiteSquare = ((row % 2 == 0) && (column % 2 == 0)) || ((row % 2 != 0) && (column % 2 != 0))
                let x: CGFloat = width / 2 + width * CGFloat(column)
                let y: CGFloat = width / 2 + width * CGFloat(row)
                
                Rectangle()
                    .foregroundColor(isWhiteSquare ? .whiteSquare : .blackSquare)
                    .frame(width: width, height: width)
                    .position(x: x, y: y)
            }
        }
    }
    
    @ViewBuilder
    private func chessPieces(with width: CGFloat) -> some View {
        ForEach(pieces.indices) { index in
            let piece = pieces[index]
            let x: CGFloat = width / 2 + width * CGFloat(piece.column)
            let y: CGFloat = width / 2 + width * CGFloat(piece.row)
            let position: CGPoint = CGPoint(x: x, y: y)
            
            Image(piece.imageName)
                .frame(width: width, height: width)
                .position(piece.isSelect ? dragPosition : position)
                .zIndex(piece.isSelect ? 1 : 0)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragPosition = value.location
                            pieces[index].isSelect = true
                        }
                        .onEnded { value in
                            pieces[index].index = findIndex(for: value.location, with: width)
                            pieces[index].isSelect = false
                        }
                )
        }
    }
    
    private func findIndex(for position: CGPoint, with width: CGFloat) -> Int {
        let row: Int = Int(position.y / width)
        let colum: Int = Int(position.x / width)
        
        return 8 * row + colum
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}

extension Piece {
    var row: Int { index / 8 }
    var column: Int { index % 8 }
}

struct BoardNumbersView: View {
    private let numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ForEach(numbers, id: \.self) { number in
                        Text(number)
                            .frame(width: geo.size.width, height: geo.size.width)
                }
            }
        }
    }
}

struct BoardLettersView: View {
    private let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Spacer(minLength: geo.size.height)
                ForEach(letters, id: \.self) { letter in
                        Text(letter)
                            .frame(width: geo.size.height, height: geo.size.height)
                }
                Spacer(minLength: geo.size.height)
            }
        }
    }
}
