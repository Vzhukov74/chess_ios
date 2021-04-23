//
//  BoardNumbersView.swift
//  chess
//
//  Created by Владислав Жуков on 23.04.2021.
//

import SwiftUI

struct BoardNumbersView: View {
    private let numbers = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ForEach(numbers, id: \.self) { number in
                        Text(number)
                            .font(.headline)
                            .frame(width: geo.size.width, height: geo.size.width)
                }
            }
        }
    }
}

struct BoardNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        BoardNumbersView()
    }
}
