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
    @State var winningSum = 21
   // @State var winSum = 0
    
    // skapa en sheet när någon av tärningar har nått 21 och då ska den veta om det är sant eller falskt.
    @State var WinSheetOne = false
    @State var WinSheetTwo = false

    var body: some View {
        
        // bakgrundens färger och egenskaper
        ZStack{
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
        
        // MARK: - BODY
        VStack {
            HStack{
            Text("Player 1 : \(sumOne)")
                  .font(.title)
                  .foregroundColor(.white)
                  .fontWeight(.semibold)
                  .padding()
                
                Text("Player 2 : \(sumTwo)")
                      .font(.title)
                      .foregroundColor(.white)
                      .fontWeight(.semibold)
                      .padding()                }
       
            Spacer()
            HStack{
                // skapar en tärning från  structen diceview
                // med dessa kan du skapa hur många tärningar du vill utan att ska flera image filer.
        
                
                DiceView(n: diceOne)
                DiceView(n: diceTwo)
                       }.onAppear(){
                //när appen startar slumpas tärningens värde utan att du behöver trycka någonstans
                newValueOnDiceTwo()
                newValueOnDiceOne()
                
            }
            Spacer()
            
            Button (action:{
                // kallar på tärnings funktionen när knappen trycks
                rollDiceOne()
                rollDiceTwo()
                
            }, label: {
                Text("Roll dice player 1")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
            })
            // knappens design
            .background(Color.green)
            .cornerRadius(15.0)
            
             
            
            // knapp för BOT tärningen
            
            Button (action:{
                // kallar på tärnings funktionen när knappen trycks
                rollDiceTwo()
                rollDiceOne()
                
            }, label: {
                Text("Roll dice player 2")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
            })
            // knappens design
            .background(Color.blue)
            .cornerRadius(15.0)
            Spacer()
        }
        
    }
    // här slutar Zstack
        
        //  här skapar vi den sheet vi ser när man fått 21 poäng
        .sheet(isPresented: $WinSheetOne, onDismiss: {
            sumOne = 0
        }, content: {
            
            
            DiceRoll.WinSheetOne(winSum: sumOne)
                
        
            
            
        })
        
        .sheet(isPresented: $WinSheetTwo, onDismiss: {
            sumTwo = 0
        }, content: {
            
            
            
                
        
            DiceRoll.WinSheetTwo(winSum: sumTwo)
            
            
        })        //:BODY
        
        
        
}
    func rollDiceOne(){
        
        newValueOnDiceOne()
        // visar den specifika tärningens värde och adderar efter varje kast
         sumOne += diceOne
         
        // spelet avslutas när man nåt 21 eller högre och man blir skicka till den nya sidan/sheet
        if (sumOne > winningSum){
            WinSheetOne = true
            
        } else if (sumOne < winningSum) {
            WinSheetOne = false
        }
        
    
        
    }
    
    func rollDiceTwo(){
        
        newValueOnDiceTwo()
        
        sumTwo += diceTwo
        
        if (sumTwo > winningSum){
            
            WinSheetTwo = true
        } else if (sumTwo < winningSum){
            WinSheetTwo = false
        }
        
        
    }


    // skapa ett randomiserat nummer på tärningen
    func newValueOnDiceOne(){
        
        diceOne = Int.random(in: 1...6)
        
    }
    // ----11----
    func newValueOnDiceTwo(){
        diceTwo = Int.random(in: 1...6)

    }
        
        
}

// skapa en tärning
struct DiceView : View {
    
    let n : Int
    
    var body: some View {
        
        Image(systemName: "die.face.\(n).fill")
            .resizable()
            .aspectRatio( contentMode: .fit)
            .padding()
            .foregroundColor(.black)
         
       
    }
    
    
}
struct WinSheetOne : View {
    
    let winSum : Int
    
    // En ny sida/sheet har en body
    
    var body : some View {
          ZStack{
            Color(red: 100/256, green: 20/256, blue: 129/256)
                .ignoresSafeArea()
            VStack{
                Text("You won Player 1!")
                    .foregroundColor(.white)
                    .font(.title)
                Text("\(winSum)")
                    .foregroundColor(.red)
                    .font(.title)
             
            
              HStack{
              Image(systemName: "trophy.circle.fill")
                      
                      .resizable()
                      .foregroundColor(.yellow)
                  .aspectRatio( contentMode: .fit)
                  .padding()
                  
                  }
                
                }
        }
        
        
        
    }
    
    
}
struct WinSheetTwo : View {
    
    let winSum : Int
    
    // En ny sida/sheet har en body
    
    var body : some View {
          ZStack{
            Color(red: 38/256, green: 158/256, blue: 595/256)
                .ignoresSafeArea()
            VStack{
                Text("You won Player 2!")
                    .foregroundColor(.white)
                    .font(.title)
                Text("\(winSum)")
                    .foregroundColor(.red)
                    .font(.title)
                HStack{
                Image(systemName: "trophy.circle.fill")
                        
                        .resizable()
                        .foregroundColor(.yellow)
                    .aspectRatio( contentMode: .fit)
                    .padding()
                    
                    }
                }
            
        }
        
        
        
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
        //WinSheetTwo(winSum: 23)
        
    }
}
