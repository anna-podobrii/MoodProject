//
//  MoodView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct MoodView: View {
    @Binding var displayMode: GeneralDisplayMode
    
    var body: some View {
        ZStack {
            displayMode.colorBackground
            .ignoresSafeArea()
        VStack {
        Text("Mood")
                .font(.system(size: 20.0, weight: .regular))
                .foregroundColor(.white)
                .padding(.top, 30)
            Spacer()
        }
        }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(displayMode: .constant(.mood))
    }
}
