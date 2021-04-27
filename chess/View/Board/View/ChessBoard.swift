//
//  ChessBoard.swift
//  chess
//
//  Created by Владислав Жуков on 26.04.2021.
//

import SwiftUI

struct ChessBoard: View {
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width / 8
            let size = CGSize(width: width, height: width)
            
            Path { path in
                for row in 0..<8 {
                    var isBlackSquare: Bool = row % 2 != 0
                    for column in 0..<8 {
                        if isBlackSquare {
                            let x: CGFloat =  width * CGFloat(column)
                            let y: CGFloat =  width * CGFloat(row)
                            let position = CGPoint(x: x, y: y)

                            path.addRect(CGRect(origin: position, size: size))
                        }
                        isBlackSquare.toggle()
                    }
                }
            }
                .foregroundColor(.blackSquare)
        }
            .background(Color.whiteSquare)
    }
}
