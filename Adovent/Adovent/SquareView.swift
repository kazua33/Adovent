//
//  SquareView.swift
//  Adovent
//
//  Created by cmStudent on 2022/05/02.
//

import SwiftUI

struct SquareView: View {
    @StateObject var viewModel = GameManagaer()
    var lampChanged: [Color]
    var proxy: GeometryProxy
    var position: Int
    var press: [Bool]
    var body: some View {
        Rectangle()
            .fill(press[position] ? .blue : lampChanged[position])
            .frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15)
            .border(viewModel.borderColor, width: 5)
    }
}
