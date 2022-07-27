//
//  NoticeView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct NoticeView: View {
    @EnvironmentObject var dataControler: DataController
    @Binding var displayMode: GeneralDisplayMode
    @Binding var colorScheme: ColorScheme
    
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
                if dataControler.moods != [] {
                ForEach(dataControler.moods) {item in
                    VStack(alignment: .center) {
                        Text(item.date, format: .dateTime.day().month().year().hour().minute())
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
                    .foregroundColor(.white)
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
