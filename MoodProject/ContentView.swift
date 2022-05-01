//
//  ContentView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataController = DataController()
    @State private var displayMode: GeneralDisplayMode = .mood
    @State private var colorScheme: ColorScheme = .blue
    @State private var showMenu: Bool = true
    
    var body: some View {
        ZStack (alignment: .top) {
        ZStack (alignment: .bottom) {
            GeneralView(displayMode: $displayMode, colorScheme: $colorScheme).environmentObject(dataController)
            BottomNavigationButtons(displayMode: $displayMode).environmentObject(dataController)
        }
            TopNavigationButtons(colorScheme: $colorScheme, showMenu: $showMenu).environmentObject(dataController)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
