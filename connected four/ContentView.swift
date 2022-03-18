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
    var redWin = 0
    @State var redtimes = 21
    var yellowWin = 0
    @State var yellowtimes = 21
    var body: some View {
        
        VStack(){
            HStack(alignment:.top){
                VStack(alignment: .leading){
                    Image("yellow")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("出手剩餘\(yellowtimes)次")
                    Text("Win : \(yellowWin)")
                }
                .padding()
                
                Spacer()
                
                VStack{
                    if(player==1){
                        Text("目前輪到 : 紅")
                        Image("red")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    else{
                        Text("目前輪到 : 黃")
                        Image("yellow")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
               
                
                Spacer()

                VStack(alignment: .trailing){
                    Image("red")
                        .resizable()
                        .frame(width: 50, height: 50 )
                    Text("出手剩餘\(redtimes)次")
                    Text("Win : \(redWin)")
                }
                .padding()
            }
            
            
            let columns = Array(repeating: GridItem(), count: 6)
            LazyVGrid(columns: columns) {
                ForEach(0..<42) { item in
                    CircleView(circles : $circleArray, player:$player, yellowtimes:$yellowtimes, redtimes:$redtimes, index: item)
                }
            }
            
            Button{
                redtimes = 21
                yellowtimes = 21
                player = 1
                for i in (0..<42){
                    circleArray[i] = 0
                }
                    
            }label:{
                Image("restart")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(5)
            }
         
        
        }
        .offset(y:-150)
        
        
        
    }
}



struct CircleView: View {
    
    @Binding var circles: Array<Int>
    @Binding var player : Int
    @Binding var yellowtimes : Int
    @Binding var redtimes : Int
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
//                Text(String(index))
                
            }
        }
        .onTapGesture {
            let judge = judgeIndex(circles: circles, index: index)
            var final = -1
            if(judge != -1 && circles[judge] != 1 && circles[judge] != 2){
                circles[judge] = player
                if(player==1){
                    redtimes -= 1
                    player = 2
                }
                else{
                    yellowtimes -= 1
                    player = 1
                }
                final = judgeGame(circles: circles, index: judge)
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

func judgeGame(circles:Array<Int>,index:Int)->Int{
    var final = [0,0,0,0,0,0,0]
    let column = index / 6
    let row = index % 6
    var target = index
    var ans = -1
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
        
        //rightup
        target = index
        target = target + 1*i - 6*i
        if(target < (column+1)*6 && target <= row && circles[target] == circles[index]){
            final[5] += 1
        }
        
        //leftup
        target = index
        target = target - 1*i - 6*i
        if(target >= column*6 && target <= row && circles[target] == circles[index]){
            final[6] += 1
        }
    }
    for i in (0..<7){
        if(final[i]==3){
            ans = i
            break
        }
    }
    return ans
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
