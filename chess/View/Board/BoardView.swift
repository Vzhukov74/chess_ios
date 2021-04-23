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

struct BoardView: View {
    @ObservedObject var model: Board
    @State private var movingIndex: Int?
    @State private var dragPosition: CGPoint = .zero
            
    var body: some View {
        VStack {
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
            
            Rectangle()
                .foregroundColor(.red)
                .onTapGesture {
                    var pieces = model.pieces
                    pieces[Int.random(in: 0...31)].index = Int.random(in: 0...63)
                    model.onNew(with: pieces)
                }
        }

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
        ForEach(model.pieces.indices) { index in
            let piece = model.pieces[index]
            let x: CGFloat = width / 2 + width * CGFloat(piece.column)
            let y: CGFloat = width / 2 + width * CGFloat(piece.row)
            let position: CGPoint = CGPoint(x: x, y: y)
            
            Image(piece.figure)
                .frame(width: width, height: width)
                .position(withAnimation { piece.index == movingIndex ? dragPosition : position })
                .zIndex(piece.isSelect ? 1 : 0)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragPosition = value.location
                            movingIndex = model.pieces[index].index
                        }
                        .onEnded { value in
                            model.pieces[index].index = findIndex(for: value.location, with: width)
                            movingIndex = nil
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
        BoardView(model: Board(with: Chess.inition))
    }
}
