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
            }
        }
        .onTapGesture {
            let judge = judgeIndex(circles: circles, index: index)
            if(judge != -1){
                circles[judge] = player
                if(player==1){
                    player = 2
                }
                else{
                    player = 1
                }
            }
            judgeGame(circles: circles, index: judge)
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
    var final = [0,0,0,0,0,0,0,0]
    //right
    var right = index
    for i in (0..<3){
        right = right + 1
        if(right > index/5*6+5){
            break
        }
        else if(circles[right] != circles[index]){
            break
        }
        else{
            final[0]+=1
        }
    }
    
    //left
    var left = index
    for i in (0..<3){
        left = right - 1
        if(right < index/5*6){
            break
        }
        else if(circles[left] != circles[index]){
            break
        }
        else{
            final[1] += 1
        }
    }
    
    //up
    var up = index
    for i in (0..<3){
        up = up - 6
        if(up/6<0){
            break
        }
        else if(circles[up] != circles[index]){
            break
        }
        else{
            final[2] += 1
        }
    }
    
    //down
    var down = index
    for i in (0..<3){
        down = down + 6
        if(down/6 > 6){
            break
        }
        else if(circles[down] != circles[index]){
            break
        }
        else{
            final[3] += 1
        }
    }
    
    //upright
    var upright = index
    for i in (0..<3){
        upright = upright + 1 - 6
        if(upright > index/5*6+5 || upright%6<0){
            break
        }
        else if(circles[down] != circles[index]){
            break
        }
        else{
            final[4] += 1
        }
    }
    
    //downright
    var downright = index
    for i in(0..<3){
        downright = downright + 1 + 6
        if(downright > index/5*6+5 || downright%6>6){
            break
        }
        else if(circles[down] != circles[index]){
            break
        }
        else{
            final[5] += 1
        }
    }
    
    //upleft
    var upleft = index
    for i in (0..<3){
        upleft = upleft - 1 - 6
        if(upleft%6<0 || upleft < index/5*6){
            break
        }
        else if(circles[down] != circles[index]){
            break
        }
        else{
            final[6] += 1
        }
    }
    
    //downleft
    var downleft = index
    for i in(0..<3){
        downleft = index
        if(downleft%6 > 6 || downleft < index/5*6){
            break
        }
        else if(circles[down] != circles[index]){
            break
        }
        else{
            final[7] += 1
        }
    }
    
    for i in final{
        if(final[i] == 3){
            print(i)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
