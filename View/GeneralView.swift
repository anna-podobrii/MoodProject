//
//  GeneralView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

enum GeneralDisplayMode {
    case mood
    case notation
    case calendar
    case statistic
   
    
    var titleForButton: String {
        switch self {
        case .mood:
            return ""
        case .notation:
            return "List"
        case .calendar:
            return "Map"
        case .statistic:
            return "Grid"
        }
    }
    
    
    
    
    var colorBackground: Color {
        switch self {
        case .mood:
            return .green
        case .notation:
            return .blue
        case .calendar:
            return .purple
        case .statistic:
            return .pink
        }
    }

    }


struct GeneralView: View {
    @EnvironmentObject var dataController: DataController
    @Binding var displayMode: GeneralDisplayMode
    @State var currentItemIsFavorite: Bool = false

    var body: some View {
        ZStack {
            switch displayMode {
            case .mood:
                MoodView(displayMode: $displayMode).environmentObject(dataController)
                    .transition(.circular)
            case .notation:
                NoticeView(displayMode: $displayMode).environmentObject(dataController)
                    .transition(.circular)
            case .calendar:
                CalendarView(displayMode: $displayMode).environmentObject(dataController)
                    .transition(.circular)
            case .statistic:
                StatisticView(displayMode: $displayMode).environmentObject(dataController)
                    .transition(.circular)
            }
        }
        .background(displayMode.colorBackground)
    }
}



