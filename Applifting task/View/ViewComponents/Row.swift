//
//  Row.swift
//  Applifting task
//
//  Created by Terka on 26.04.2023.
//

import SwiftUI

struct Row: View {
    @State var launch: Launch
    
    private func formattedDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d. M. yyyy"
        return dateFormatter.string(from: launch.dateUnix)
    }
    
    var body: some View {
        HStack {
            Image("rocket")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
                .background(Color(.white))
                .clipShape(Circle())
                .padding()
            VStack(alignment: .leading, spacing: 5) {
                Text(launch.name)
                    .font(.system(size: 25))
                Text("Launched \(formattedDay()).")
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
            }
            .foregroundColor(.white)
            .padding()
        }
        .background(Color("spaceLight"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(launch: .launchWithDetails)
    }
}
