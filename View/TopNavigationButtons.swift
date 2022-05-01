//
//  MenuView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 01.05.2022.
//

import SwiftUI

struct TopNavigationButtons: View {
    @Binding var colorScheme: ColorScheme
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            ZStack (alignment: .trailing) {
                VStack {
                    Text("Choose a color scheme")
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                HStack {
                    Circle()
                        .foregroundColor(.blue)
                        .onTapGesture {
                            colorScheme = .blue
                        }
                    Circle()
                        .foregroundColor(.red)
                        .onTapGesture {
                            colorScheme = .red
                        }
                    Circle()
                        .foregroundColor(.green)
                        .onTapGesture {
                            colorScheme = .green
                        }
                    Circle()
                        .foregroundColor(.purple)
                        .onTapGesture {
                            colorScheme = .purple
                        }
                }
                
            }
                .frame(width: 150)
                
            }
            .frame(width: 250)
            .background(Color.white)
            .offset(x: showMenu ? -400 : -100)
        HStack {
        Image(systemName: "list.bullet")
                .onTapGesture {
                    withAnimation {
                    showMenu.toggle()
                    }
                }
        }
        .offset(x:-70, y: 10)
        }
    }
}

struct TopNavigationButtons_Previews: PreviewProvider {
    static var previews: some View {
        TopNavigationButtons(colorScheme: .constant(.red), showMenu: .constant(true))
    }
}
