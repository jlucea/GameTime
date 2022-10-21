//
//  ContentView.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct MainView: View {
    
    @State var array : [String] = ["1" , "2", "3"]
    
    @State var openNewTimerScreen = false
    
    var body: some View {

        ZStack {
            
            // Using NavigationStack instead of NavigationView
            // This will require minimum target iOS16
            NavigationStack {
                VStack {
                    Spacer()
                    Text("Jaime")
                        .font(.system(size: 32))
                        .padding()
                    
                    Text("00:00:00")
                        .font(.custom("Corsiva Hebrew", size: 58, relativeTo: .title))
                    Spacer()
                    
                    // Horizontal scroll bar at the bottom of the screen
                    ScrollView(.horizontal) {
                        HStack {
                            
                            ForEach(array, id: \.self) { str in
                                TimerCard()
                                    // .frame(width: 240, height: 320, alignment:  .center)
                                    .border(.green)
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            print("Toolbar button pressed")
                            openNewTimerScreen.toggle()
                        }, label: {
                            Image(systemName: "person.crop.circle.badge.plus")})
                    }
                    /*
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink(destination: TimerCard(), label: {
                            Image(systemName: "person.crop.circle.badge.plus")
                        })
                        Button(action: {
                            print("Toolbar button pressed")
                        }, label: {
                            Image(systemName: "person.crop.circle.badge.plus")})
                    }
                    */
                    
                    //                ToolbarItem(placement: .primaryAction) {
                    //                    Button(action: {
                    //                        print("Toolbar button pressed")
                    //                    }, label: {
                    //                        Image(systemName: "person.crop.circle.badge.plus")})
                    //                }
                    
                    
                    ToolbarItem(placement: .principal) {
                        Text("GameTime").font(.headline)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Edit", action: {
                            print("Edit button pressed")
                            addCard()
                        })
                    }
                }
            }
            // .navigationViewStyle(.stack)
            
            .sheet(isPresented: $openNewTimerScreen) {
                NewTimerScreen()
            }
            
        }
    }
        
    func addCard() {
        array.append("X")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
