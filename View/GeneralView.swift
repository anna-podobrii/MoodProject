//
//  GeneralView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

enum ColorScheme {
    case blue
    case green
    case red
    case purple
   
    var colorName: String {
        switch self {
        case .blue:
            return "blue"
        case .green:
            return "green"
        case .red:
            return "red"
        case .purple:
            return "purple"
        }
    }
    
    var color: Color {
        switch self {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        case .purple:
            return .purple
        }
    }
    
    }

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
    @Binding var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            switch displayMode {
            case .mood:
                MoodView(displayMode: $displayMode, colorScheme: $colorScheme).environmentObject(dataController)
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



