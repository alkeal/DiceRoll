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
    
    
    @State var sumOne = 0
    @State var sumTwo = 0
    
    // skapa en sheet när någon av tärningar har nått 21 och då ska den veta om det är sant eller falskt.
    @State var WinSheet = false
    
    
    var body: some View {
        
        // bakgrundens färger och egenskaper
        ZStack{
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
        
        
        VStack {
            
            Text("\(sumOne)")
                  .font(.title)
                  .foregroundColor(.green)
                  .fontWeight(.bold)
              Spacer()
              
              Text("\(sumTwo)")
                    .font(.title)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                Spacer()
            
            HStack{
                // skapar en tärning från  structen diceview
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
        
        //  här skapar vi den sheet vi ser när man fått 21 poäng
        .sheet(isPresented: $WinSheet, onDismiss: {
            //sumTwo = 0
            sumOne = 0
        }, content: {
            
           // WinSheet(sumTwo: sumTwo)
            DiceRoll.WinSheet(winSum: sumOne)
            DiceRoll.WinSheet(winSum: sumTwo)
            
        })
        
        
        
        
        
        
}
    func rollDice(){
        
        newValueOnDice()
        // visar den specifika tärningens värde och adderar efter varje kast
         sumOne += diceOne
         sumTwo += diceTwo
        // spelet avslutas när man nåt 21 eller högre och man blir skicka till den nya sidan/sheet
        if (sumOne > 21){
            WinSheet = true
            
        }
        
        if (sumTwo > 21){
            
            WinSheet = true
        }
        
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
struct WinSheet : View {
    
    let winSum : Int
    //let sumTwo : Int
    
    // En ny sida/sheet har en body
    
    var body : some View {
          ZStack{
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
            VStack{
                Text("You won!")
                    .foregroundColor(.white)
                    .font(.title)
                Text("\(winSum)")
                    .foregroundColor(.red)
                    .font(.title)
             
            }
            
        }
        
        
        
    }
    
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
