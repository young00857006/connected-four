//
//  ContentView.swift
//  connected four
//
//  Created by tingyang on 2022/3/16.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var circleArray = Array(repeating: 0, count: 42)
    @State private var player = 1

    var body: some View {
        let columns = Array(repeating: GridItem(), count: 6)
        LazyVGrid(columns: columns) {
            ForEach(0..<42) { item in
                CircleView(circles : $circleArray, player:$player, index: item)
            }
        }
    }
}



struct CircleView: View {
    
    @Binding var circles: Array<Int>
    @Binding var player : Int
    var index : Int
    
    var body: some View {
       
        VStack {
            if(circles[index]==1){
                Circle()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .foregroundColor(.red)
            }
            else if(circles[index]==2){
                Circle()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .foregroundColor(.yellow)
            }
            else{
                Circle()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .foregroundColor(.blue)
                Text(String(index))
                
            }
        }
        .onTapGesture {
            let judge = judgeIndex(circles: circles, index: index)
            if(judge != -1 && circles[judge] != 1 && circles[judge] != 2){
                circles[judge] = player
                if(player==1){
                    player = 2
                }
                else{
                    player = 1
                }
                judgeGame(circles: circles, index: judge)
            }
            
        }
    }
}

/*判斷index*/
func judgeIndex(circles:Array<Int>,index:Int)->Int{
    var item = (index%6)
    var ans = -1
    
    for i in (0..<6){
        item += 6
    }
    
    for i in (0..<7){
        if(item<0 && circles[item] != 0){
            ans = -1
             break
        }
        if(circles[item]==0){
            ans = item
            break
        }
        item -= 6
    }
    return ans
}

func judgeGame(circles:Array<Int>,index:Int){
    var final = [0,0,0,0,0]
    let column = index / 6
    let row = index % 6
    var target = index
//
//    print(index)
//    print(column)
//    print(row)
//    print("-------")
//    print((column+1)*6)//right
//    print(column*6)//left
//    print(row)//up
//    print(row+36)//down
//    print("--------")
//
    for i in (1..<4){
        //right
        target = index
        target = target + 1*i
        if(target < (column+1)*6 && circles[target] == circles[index]){
            final[0] += 1
        }
        
        //left
        target = index
        target = target - 1*i
        if(target >= column*6 && circles[target] == circles[index]){
            final[1] += 1
        }
        target = index
        target = target + 6*i
        if(target <= row+36 && circles[target] == circles[index]){
            final[2] += 1
        }
        //rightdown
        target = index
        target = target + 1 * i + 6 * i
        if(target < (column+1)*6 && target <= row+36 && circles[target] == circles[index]){
            final[3] += 1
            
        }
        
        //leftdown
        target = index
        target = target - 1*i + 6*i
        if(target >= column*6 && target <= row+36 && circles[target] == circles[index]){
            final[4] += 1
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
