//
//  Factors.swift
//  MoodProject
//
//  Created by Anna Podobrii on 06.05.2022.
//

import SwiftUI

struct Factors: View {
    var body: some View {
        HStack {
        VStack {
        Circle()
            .foregroundColor(.purple)
            .frame(width: 30, height: 30)
            Text("Friends")
        }
            VStack {
            Circle()
                .foregroundColor(.green)
                .frame(width: 30, height: 30)
                Text("Home")
            }
            VStack {
            Circle()
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
                Text("Work")
            }
            VStack {
            Circle()
                .foregroundColor(.red)
                .frame(width: 30, height: 30)
                Text("Pet")
            }
    }
    }
}

struct Factors_Previews: PreviewProvider {
    static var previews: some View {
        Factors()
    }
}
