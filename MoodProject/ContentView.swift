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
    
    var body: some View {
        ZStack (alignment: .bottom) {
            GeneralView(displayMode: $displayMode).environmentObject(dataController)
            BottomNavigationButtons(displayMode: $displayMode).environmentObject(dataController)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
