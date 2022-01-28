//
//  CalendarView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct CalendarView: View {
    @Binding var displayMode: GeneralDisplayMode
    
    var body: some View {
        ZStack {
            displayMode.colorBackground
            .ignoresSafeArea()
        VStack {
        Text("Calendar")
                .font(.system(size: 20.0, weight: .regular))
                .foregroundColor(.white)
                .padding(.top, 30)
            Spacer()
        }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(displayMode: .constant(.calendar))
    }
}

