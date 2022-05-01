//
//  BottomNavigationButtons.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct BottomNavigationButtons: View {
    @Binding var displayMode: GeneralDisplayMode
    
    var body: some View {
        
        HStack {
        Button(action: {
            withAnimation(){
                displayMode = .mood
                
            }

        }, label: {
            HStack{
            Text("Mood")
            
            }
            .font(.system(size: 18.0, weight: .regular))
                .foregroundColor(.black)
        })
            Spacer()
            Button(action: {
                withAnimation(){
                    displayMode = .notation
                    
                }

            }, label: {
                HStack{
                Text("Notice")
                
                }
                .font(.system(size: 18.0, weight: .regular))
                    .foregroundColor(.black)
            })
            Spacer()
            Button(action: {
                withAnimation(){
                    displayMode = .calendar
                    
                }

            }, label: {
                HStack{
                Text("Calendar")
                
                }
                .font(.system(size: 18.0, weight: .regular))
                    .foregroundColor(.black)
            })
            Spacer()
            Button(action: {
                withAnimation(){
                    displayMode = .statistic
                    
                }

            }, label: {
                HStack{
                Text("Statistic")
                
                }
                .font(.system(size: 18.0, weight: .regular))
                    .foregroundColor(.black)
            })
    }
        .padding()
        .background(.white)
    }
}

struct BottomNavigationButtons_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationButtons(displayMode: .constant(.mood))
    }
}

