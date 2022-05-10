//
//  GameManager.swift
//  Adovent
//
//  Created by cmStudent on 2022/04/26.
//

import SwiftUI
import Combine

class GameManagaer: ObservableObject {
    @Published var isChanged = false
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var backgroundColor: Color = .white
    
    @Published var borderColor: Color = .black
    
    // 一回ごとにランプを点灯する回数を増やす
    var count = 0
    var playCount = 1
    
    var randomNum = 0
    
    var lamp: [Int] = []
    var copyLamp: [Int] = []
    var playerLamp: [Int] = []
    var faultLamp = false
    
    @Published var blueTimer = Timer.publish(every: 0.5, on: .main, in: .common)
    @Published var whiteTimer = Timer.publish(every: 0.2, on: .main, in: .common)
    @Published var redTimer = Timer.publish(every: 0.2, on: .main, in: .common)
    
    func lampPush() -> Int {
        randomNum = Int.random(in: 0..<9)
        return randomNum
    }
    
    func lampPlay(position: Int){
        print("play")
        print(position)
        playerLamp.append(position)
        if playerLamp[count] != lamp[count] {
            faultLamp = true
            redTimer = Timer.publish(every: 0.2, on: .main, in: .common)
            _ = redTimer.connect()
            count = 0
            playerLamp = []
            return
        }
        count += 1
        if count >= playCount {
            blueTimer = Timer.publish(every: 0.5, on: .main, in: .common)
            _ = blueTimer.connect()
            playerLamp = []
            count = 0
            playCount += 1
            faultLamp = false
        }
    }
    
    func lampFrash(lampChanged: [Color]) -> [Color] {
        var lampChanged = [Color](repeating: .white, count: 9)
        if lamp.count == 0 {
            print("count")
            print(count)
            let randomNum = Int.random(in: 0..<9)
            lamp.append(randomNum)
            print(randomNum)
            lampChanged[randomNum] = .blue
            print("lamp\(lamp)")
            count += 1
            return lampChanged
        } else {
            if copyLamp.count >= 1 {
                let num = copyLamp[0]
                print(count)
                copyLamp.removeFirst()
                lampChanged[num] = .blue
                print("lamp\(lamp)")
                print(playerLamp)
            } else if !faultLamp{
                let randomNum = Int.random(in: 0..<9)
                lamp.append(randomNum)
                lampChanged[randomNum] = .blue
                print("lamp\(lamp)")
                print(playerLamp)
            }
            count += 1
            return lampChanged
        }
    }
    
    func timerStart() {
        blueTimer = Timer.publish(every: 0.5, on: .main, in: .common)
        _ = blueTimer.connect()
    }
    func closure(close: () -> Void) {
        
    }
}
