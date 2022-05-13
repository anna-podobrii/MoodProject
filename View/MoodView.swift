//
//  MoodView.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import SwiftUI

struct MoodView: View {
    @EnvironmentObject var dataControler: DataController
    @Binding var displayMode: GeneralDisplayMode
    @Binding var colorScheme: ColorScheme
    @State var factors = Factors()
    @State var date: Date? = nil
    @State var factor: String = ""
    @State var factorMood: String = ""
    @State var factorImage: String = ""
    @State var amount: CGFloat = 0.0
    @State var score: Int = 0
    @State var describeMood: String = ""
    @State var checkmark:Bool = false
    
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            //returns the score as a Double
            return Double(score)
        }, set: {
            //rounds the double to an Int
            print($0.description)
            score = Int($0)
        })
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, colorScheme.color]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        VStack {
        Text("Mood")
                .font(.system(size: 20.0, weight: .regular))
                .foregroundColor(.black)
                .padding([.top, .bottom], 30)
            Text ("What's your mood right now?")
                .font(.system(size: 16.0, weight: .medium))
                .foregroundColor(.black)
            VStack{
                MoodSlider(value: $amount , range: 1.0...5.0)
                Text ("What influenced your mood?")
                    .font(.system(size: 16.0, weight: .medium))
                    .foregroundColor(.black)
                    .onTapGesture {
                        dataControler.addFactor(name: "Friends", image: "factor1")
                    }
                
                VStack {
            ForEach (dataControler.factors, id: \.self) { item in
               
                FactorView(factor: item)
                    
            }
                }
//            HStack {
//            VStack {
//
//            Circle()
//                .foregroundColor(.purple)
//                Text("Friends")
//            }
//            .frame(width: 70, height: 80)
//            .onTapGesture {
//                factor = "Friends"
//            }
//                VStack {
//                Circle()
//                    .foregroundColor(.green)
//                    Text("Home")
//                }
//                .frame(width: 70, height: 80)
//                .onTapGesture {
//                    factor = "Home"
//                }
//                VStack {
//                Circle()
//                    .foregroundColor(.blue)
//                    Text("Work")
//                }
//                .frame(width: 70, height: 80)
//                .onTapGesture {
//                    factor = "Work"
//                }
//                VStack {
//                Circle()
//                    .foregroundColor(.red)
//                    Text("Pet")
//                }
//                .frame(width: 70, height: 80)
//                .onTapGesture {
//                    factor = "Pet"
//                }
//        }
                    HStack {
            VStack {
            Text ("Add your factor")
                .font(.system(size: 16.0, weight: .medium))
                .foregroundColor(.black)
                
                HStack {
                   ForEach(dataControler.factorImageArray(), id: \.self) { item in
                       ZStack {
                        Image(item)
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(width: 30, height: 30)
                           .onTapGesture {
                               checkmark.toggle()
                               factorImage = item
                           }
                           Image(systemName: "checkmark.circle")
                               .frame(width: 30, height: 30)
                               .foregroundColor(.white)
                               .opacity(checkmark ? 0.5 : 0)
                       }
                   }
                }
                TextField("Factor's name", text: $factor)
            
            }
                        VStack {
              Image(systemName: "plus.app")
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        dataControler.addFactor(name: factor, image: factorImage)
                    }
                            Image(systemName: "plus.app")
                                  .frame(width: 30, height: 30)
                                  .onTapGesture {
                                      dataControler.deleteAllFactors()
                                  }
            }
                    }
            
            Text ("Describe your mood")
                .font(.system(size: 16.0, weight: .medium))
                .foregroundColor(.black)
            TextField("DescribeMood", text: $describeMood)
            
            HStack {
            Text ("Save")
                .onTapGesture {
                    dataControler.addMood(date: Date.now, factor: dataControler.selectedFactor?.name ?? "", rating: Int(amount), describe: describeMood)
                }
                Text ("Delete")
                    .onTapGesture {
                        dataControler.deleteAllMood()
                    }
            }
            VStack {
                if dataControler.moods != [] {
                ForEach(dataControler.moods) {item in
                    HStack {
                        Text(item.date, format: .dateTime.day().month().year().hour().minute())
                    Text (item.factor)
                        Text ("\(item.rating)")
                        Text (item.describeMood ?? "")
                    }
                }
                }
            }
            }
        }
        .padding(.bottom, 80)
        }
        }
    }


struct MoodSlider: View {
    
    @Binding var value: CGFloat
    @State var lastOffset: CGFloat = 0
    var range: ClosedRange<CGFloat>
    var leadingOffset: CGFloat = 0
    var trailingOffset: CGFloat = 0
    
    var knobSize: CGSize = CGSize(width: 20, height: 0)

    var body: some View {
        
        GeometryReader { geometry in
            VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 320, height: 15)
                    .foregroundColor(.white)
                    .offset(x:0)
                HStack {
                    TickMarkView(mood: "Very bad")
                    TickMarkView(mood: "Bad")
                    TickMarkView(mood: "OK")
                    TickMarkView(mood: "Good")
                    TickMarkView(mood: "Very good")
 
                }
                .frame(width: 290)
                .offset(x:0, y:10)
                HStack {
                    ZStack {
                        if value <= 1.5 {
                        Image ("first_mood")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40)
                            .shadow(radius: 4)
                        }
                        if value > 1.5 && value <= 2.5 {
                            Image ("second_mood")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40)
                                .shadow(radius: 4)
                            }
                        if value > 2.5 && value <= 3.5 {
                            Image ("third_mood")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40)
                                .shadow(radius: 4)
                            }
                        if value > 3.5 && value <= 4.5 {
                            Image ("fourth_mood")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40)
                                .shadow(radius: 4)
                            }
                        if value > 4.5 {
                            Image ("fifth_mood")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40)
                                .shadow(radius: 4)
                        }
                    }
                    .frame(width: self.knobSize.width, height: self.knobSize.height)
                    .offset(x: self.$value.wrappedValue.map (from: self.range,  to: self.leadingOffset...(geometry.size.width - self.knobSize.width - self.trailingOffset)), y:-35)
                    
                    
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                if abs(value.translation.width) < 1 {
                                    self.lastOffset = self.$value.wrappedValue.map(from: self.range, to: self.leadingOffset...(geometry.size.width - self.knobSize.width - self.trailingOffset))
                                    
                                }
                                
                                let sliderPos = max(1 + self.leadingOffset, min(self.lastOffset + value.translation.width, geometry.size.width - self.knobSize.width - self.trailingOffset))
                                let sliderVal = sliderPos.map(from: self.leadingOffset...(geometry.size.width - self.knobSize.width - self.trailingOffset), to: self.range)
                                
                                
                                self.value = sliderVal
                            }
                        
                    )
                    Spacer()
                }
                
            }
                  
     
            HStack (alignment: .center){
                Text ("Your mood rating is ")
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundColor(.white)
                
                Text ( "\(round(value), specifier: "%.0f")")
                    .font(.system(size: 18.0, weight: .medium))
                    .foregroundColor(value < 2.5 ? Color.red : Color.blue)
                    .frame(width: 30)
                    
                    .background(RoundedRectangle(cornerRadius: 5.0)
                                    .foregroundColor(.white)
                       )
                Text ( "now")
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundColor(.white)
            }
            
            .offset(y:30)
            
        }
            
        }
        .frame(width: 300)
        .padding(.top, 50)
        .padding(30)
    }
}
extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        
        let value = self.clamped(to: from)
        
        let fromRange = from.upperBound - from.lowerBound
        let toRange = to.upperBound - to.lowerBound
        let result = (((value - from.lowerBound) / fromRange) * toRange) + to.lowerBound
        return result
    }
}
extension Comparable {
    func clamped(to r: ClosedRange<Self>) -> Self {
        let min = r.lowerBound, max = r.upperBound
        return self < min ? min : (max < self ? max : self)
    }
}

struct TickMarkView: View {
    let mood: String

    
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 1)
                .frame(width:1, height: 10)
                .foregroundColor(.black)
            Text (mood)
                .font(.system(size: 12.0, weight: .regular))
                .foregroundColor(.black)
        }
        .padding(.top, mood.count == 0 ? 7 : 0)
        .frame(width: 60)
    }
}

struct FactorView: View {
    @EnvironmentObject var dataControler: DataController
    var factor: Factors
    @State var checkmark:Bool = false
    

    var body: some View {
        ZStack {
        VStack {
            Image(factor.image ?? "")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)

            Text(factor.name)
        }
        .frame(width: 70, height: 80)
        .onTapGesture {
            dataControler.selectedFactor = factor
            checkmark.toggle()
        }
            Image(systemName: "checkmark.circle")
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .opacity(checkmark ? 0.5 : 0)
    }
    }
    
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(displayMode: .constant(.mood), colorScheme: .constant(.blue), amount: 0)
    }
}
