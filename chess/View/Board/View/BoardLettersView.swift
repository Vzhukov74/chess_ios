//
//  BoardLettersView.swift
//  chess
//
//  Created by Владислав Жуков on 23.04.2021.
//

import SwiftUI

struct BoardLettersView: View {
    private let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Spacer(minLength: geo.size.height)
                ForEach(letters, id: \.self) { letter in
                        Text(letter)
                            .font(.headline)
                            .frame(width: geo.size.height, height: geo.size.height)
                }
                Spacer(minLength: geo.size.height)
            }
        }
    }
}

struct BoardLettersView_Previews: PreviewProvider {
    static var previews: some View {
        BoardLettersView()
    }
}
