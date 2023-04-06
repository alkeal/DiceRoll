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
    
    
    @State var BettingSheet = false
    @State var coinsP1 = 100
    @State var coinsP2 = 100
    @State var coinWin = 0

    var body: some View {
        
        // bakgrundens färger och egenskaper
        ZStack{
        
            Color(red: 38/256, green: 97/256, blue: 79/256)
                .ignoresSafeArea()
        
        // MARK: - BODY
        VStack {
            HStack{
                Text("Player 1 : \(sumOne)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                
                Text("Player 2 : \(sumTwo)")
                      .font(.title)
                      .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                      .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])                }
       
            Spacer()
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
                Text("Player 1 Roll Dice")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))
                    .multilineTextAlignment(.center)
                    .padding()
                   
            })
            // knappens design
            .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))            .cornerRadius(15.0)
             
          
            // knapp för BOT tärningen
            
            Button (action:{
                // kallar på tärnings funktionen när knappen trycks
                rollDiceTwo()
              //  rollDiceOne()
                
            }, label: {
                Text("Player 2 Roll Dice")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .multilineTextAlignment(.center)
                    .padding()
            })
            // knappens design
            .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))
            .cornerRadius(15.0)
            .padding()
             Spacer()
            
              Button(action: {
                 
                  self.coinsP1 += 1
                  
              }, label: {
                  HStack{
                      Spacer()
                  Text("Bet coins on P1 : \(coinsP1)")
                      .font(.title)
                      .fontWeight(.regular)
                      .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))  .multilineTextAlignment(.leading)
                      .padding(.all,15)
                      .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))                      .cornerRadius(20.0);
                      Spacer()
                      
                  
                      }
              })
            Button(action: {
               
                self.coinsP2 += 1
                
            }, label: {
                HStack{
                   
                    Text("Bet coins on P2 : \(coinsP2)")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))  .multilineTextAlignment(.leading)
                    .padding(.all,15)
                    .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))                    .cornerRadius(20.0);
                    }
                
             })
            
        }
           
            
         
    }
    // här slutar Zstack
        
        //  här skapar vi den sheet vi ser när man fått 21 poäng
        .sheet(isPresented: $WinSheetOne, onDismiss: {
            sumOne = 0
        }, content: {
            
            
            DiceRoll.WinSheetOne(winSum: sumOne, coinWin: coinsP1)
                
        
            
            
        })
        
        .sheet(isPresented: $WinSheetTwo, onDismiss: {
            sumTwo = 0
        }, content: {
            
            
            
                
        
            DiceRoll.WinSheetTwo(winSum: sumTwo, coinWin: coinsP2)
            
            
        })        //:BODY
        
        
}
    func rollDiceOne(){
        
        newValueOnDiceOne()
        addCoinToBet()
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
        //addCoinToBet()
        
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
        
        
        if diceOne > 21 {
            self.coinsP1 += coinWin * 30
        } else{
            self.coinsP1 -= coinWin
        }    }
    
    // ----11----
    
    func newValueOnDiceTwo(){
        
        diceTwo = Int.random(in: 1...6)

        // kolla om du vann coins
        if diceTwo > 21 {
            self.coinsP2 += coinWin * 30
        } else{
            self.coinsP2 -= coinWin
        }
        
    }
    
   func addCoinToBet(){
       
       
        
       if diceTwo > 21 {
           self.coinsP2 += coinWin * 10
       } else{
           self.coinsP2 -= coinWin
       }
        
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
    let coinWin : Int
    
    // En ny sida/sheet har en body
    
    var body : some View {
        ZStack{
            Color(red: 38/256, green: 97/256, blue: 79/256)
                .ignoresSafeArea()
          VStack{
              Text("You won Player 1 : \(winSum)")
                  .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .font(.title)
                  .padding()
                  .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))
                  .cornerRadius(15.0)
                  .padding()
              
              Text("You won \(coinWin) coins!")
                  .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .multilineTextAlignment(.center)
                  .padding()
                  .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))
                  .cornerRadius(15.0)
                  .padding()
              HStack{
              Image(systemName: "eurosign.circle.fill")
                      
                      .resizable()
                      .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .aspectRatio( contentMode: .fit)
                  .padding()
                  
                  }
                }
        }
        
        
        
    }
    
    
}
struct WinSheetTwo : View {
    
    let winSum : Int
    let coinWin : Int
    
    // En ny sida/sheet har en body
    
    var body : some View {
          ZStack{
              Color(red: 38/256, green: 97/256, blue: 79/256)
                  .ignoresSafeArea()
            VStack{
                Text("You won Player 2 ! This was your score :  \(winSum)")
                    .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .font(.title)
                    .padding()
                    .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))
                    .cornerRadius(15.0)
                    .padding()
                
                Text("You won \(coinWin) coins!")
                    .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(hue: 0.414, saturation: 0.01, brightness: 0.091, opacity: 0.705))
                    .cornerRadius(15.0)
                    .padding()
                HStack{
                Image(systemName: "eurosign.circle.fill")
                        
                        .resizable()
                        .foregroundColor(Color(hue: 0.323, saturation: 0.413, brightness: 0.861))                    .aspectRatio( contentMode: .fit)
                    .padding()
                    
                    }
                }
            
        }
        
        
        
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    //ContentView()
      //  WinSheetOne(winSum: 23, coinWin: 0)
        WinSheetTwo(winSum: 23, coinWin: 0)
    }
}
