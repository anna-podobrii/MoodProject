//
//  MenuView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 01.05.2022.
//

import SwiftUI

struct MenuView: View {
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            VStack {
                Text("Choose a color scheme")
                    .multilineTextAlignment(.center)
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
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(colorScheme: .constant(.purple))
    }
}
