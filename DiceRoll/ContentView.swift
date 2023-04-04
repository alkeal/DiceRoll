//
//  ContentView.swift
//  DiceRoll
//
//  Created by A on 2023-04-03.
//

import SwiftUI

struct ContentView: View {
    
    //skapa en tärning
    @State var diceOne = 1
    @State var diceTwo = 2
    
    
    @State var sum = 0
    
    
    var body: some View {
        
        // bakgrundens färger och egenskaper
        ZStack{
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
        
        
        VStack {
            
            
          Text("\(sum)")
                .font(.title)
                .foregroundColor(.green)
                .fontWeight(.bold)
            Spacer()
            
          
            HStack{
                // skapar en tärning frå  structen diceview
                // med dessa kan du skapa hur många tärningar du vill utan att ska flera image filer.
                DiceView(n: diceOne)
                DiceView(n: diceTwo)
                
            }.onAppear(){
                //när appen startar slumpas tärningens värde utan att du behöver trycka någonstans
                newValueOnDice()
                
            }
            Button (action:{
                // kallar på tärnings funktionen när knappen trycks
                rollDice()
                
                
            }, label: {
                Text("Roll Dice")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding()
            })
            // knappens design
            .background(Color.red)
            .cornerRadius(15.0)
            Spacer()
             

        }
        
    }
    // här slutar Zstack
}
    func rollDice(){
        
        newValueOnDice()
        
         sum += diceOne
         sum += diceTwo
        
    }


    // skapa ett randomiserat nummer på tärningen
    func newValueOnDice(){
        
        diceOne = Int.random(in: 1...6)
        diceTwo = Int.random(in: 1...6)
        
    }
        
        
}

// skapa en tärning
struct DiceView : View {
    
    let n : Int
    
    var body: some View {
        
        Image(systemName: "die.face.\(n)")
            .resizable()
            .aspectRatio( contentMode: .fit)
            .padding()
       
    }
    
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
