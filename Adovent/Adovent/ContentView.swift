//
//  ContentView.swift
//  Adovent
//
//  Created by cmStudent on 2022/04/26.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = GameManagaer()
    var body: some View {
        GameView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
