//
//  GameView.swift
//  Adovent
//
//  Created by cmStudent on 2022/04/26.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameManagaer()
    // ９マスの色の変換
    @State var lampChanged: [Color] = [.white,.white,.white,
                                       .white,.white,.white,
                                       .white,.white,.white]
    // 動作している間に押せなくするための変数
    @State var timeStatus = false
    
    // 長押ししている間の処理を管理する変数
    @State var press = [false, false, false,
                        false, false, false,
                        false, false, false]
    
    @State var pressing = true
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    /// 縦方向にグリッドを生成する
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            // columnsにより４個目、７個目は自動的に2,3行目に表示する
                            ZStack {
                                Rectangle()
                                    .fill(press[i] ? .blue : lampChanged[i])
                                    .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
                                    .border(viewModel.borderColor, width: 5)
                                
                                Button("                                                     "){
                                    
                                    if press[i] {
                                        press[i] = false
                                        pressing = true
                                    } else {
                                        
                                    }
                                    if timeStatus {
                                        viewModel.lampPlay(position: i)
                                    }
                                    
                                }
                                .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
                            }
                            .simultaneousGesture(
                                
                                LongPressGesture(minimumDuration: 0,maximumDistance: 1000).onEnded{ _ in
                                    if timeStatus {
                                        press[i] = true
                                    }
                                }
                            )
                        }
                        
                    }
                    Spacer()
                        .onReceive(viewModel.blueTimer){ _ in
                            timeStatus = false
                            if viewModel.count >= viewModel.playCount {
                                lampChanged = [Color](repeating: .white, count: 9)
                                viewModel.copyLamp = viewModel.lamp
                                timeStatus = true
                                print(timeStatus)
                                viewModel.count = 0
                                viewModel.blueTimer.connect().cancel()
                            } else {
                                viewModel.whiteTimer = Timer.publish(every: 0.2, on: .main, in: .common)
                                _  = viewModel.whiteTimer.connect()
                                lampChanged = [Color](repeating: .white, count: 9)
                                viewModel.blueTimer.connect().cancel()
                            }
                        }
                        .onReceive(viewModel.whiteTimer){ _ in
                            lampChanged = viewModel.lampFrash(lampChanged: lampChanged)
                            viewModel.blueTimer = Timer.publish(every: 0.5, on: .main, in: .common)
                            _ = viewModel.blueTimer.connect()
                            
                            viewModel.whiteTimer.connect().cancel()
                        }
                        .onReceive(viewModel.redTimer){ _ in
                            lampChanged = [Color](repeating: .red, count: 9)
                            viewModel.blueTimer = Timer.publish(every: 0.5, on: .main, in: .common)
                            _ = viewModel.blueTimer.connect()
                            
                            viewModel.redTimer.connect().cancel()
                        }
                        .onAppear{
                            lampChanged = viewModel.lampFrash(lampChanged: lampChanged)
                            viewModel.timerStart()
                        }
                }
            }
        }
    }
}
