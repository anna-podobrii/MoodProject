//
//  NoticeView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct NoticeView: View {
    @EnvironmentObject var dataController: DataController
    @Binding var displayMode: GeneralDisplayMode
    @Binding var colorScheme: ColorScheme
    @State var showingDateSelector: Bool = false
    @State var showingAllNotice: Bool = false
    
    var selectedDayFormatter:DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        return formatter
    }
    let selectionDateRange: ClosedRange<Date> = {
        return Date.oneYearFromCurrentDate()...Date()
    }()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, colorScheme.color]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("Notice")
                        .font(.system(size: 20.0, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    VStack {
                    HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16.0))
                                .onTapGesture {
                                    withAnimation {
                                        dataController.selectedDate = dataController.selectedDate.prevDate()
                                    }
                                }
                            Text(selectedDayFormatter.string(from: dataController.selectedDate))
                                .font(.system(size: 14.0, weight: .medium))
                        .onTapGesture {
                            withAnimation {
                            showingDateSelector.toggle()
                            }
                        }
                        Text("All")
                            .font(.system(size: 14.0, weight: .medium))
                            .onTapGesture {
                                withAnimation {
                                    showingAllNotice.toggle()
                                }
                            }
                    }
                        if showingDateSelector {
                            DatePicker("Select a date",
                                       selection: $dataController.selectedDate.animation(),
                                       in: selectionDateRange,
                                       displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .onChange(of: dataController.selectedDate) { newValue in
                                    withAnimation {
                                        showingDateSelector = false
                                    }
                                }
                        }
                    }
            VStack {
                if dataController.moods != [] {
                    ForEach(dataController.moods) {item in
                        if showingAllNotice == false {
                        VStack(alignment: .center) {
                            let sameDay = Calendar.current.isDate(dataController.selectedDate, equalTo: item.date, toGranularity: .day)
                            if sameDay {
                            VStack {
                                HStack {
                                    Text (item.factor)
                                    Text ("\(item.rating)")
                                    
                                }
                                .padding([.top, .bottom], 5.0)
                                Text (item.describeMood ?? "")
                            }
                            .foregroundColor(colorScheme.color)
                            .padding(5.0)
                            .background(RoundedRectangle(cornerRadius: 5.0)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.9)
                            
                            )
                        }
                        }
                        } else {
                            VStack(alignment: .center) {
                                VStack {
                                    HStack {
                                        Text (item.factor)
                                        Text ("\(item.rating)")
                                        
                                    }
                                    .padding([.top, .bottom], 5.0)
                                    Text (item.describeMood ?? "")
                                }
                                .foregroundColor(colorScheme.color)
                                .padding(5.0)
                                .background(RoundedRectangle(cornerRadius: 5.0)
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width * 0.9)
                                
                                )
                            }
                        }
                    }
                }
            }
        }
    }

}

    }
}


struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView(displayMode: .constant(.notation), colorScheme: .constant(.blue))
    }
}
