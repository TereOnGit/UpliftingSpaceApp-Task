//
//  DetailView.swift
//  Applifting task
//
//  Created by Terka on 05.04.2023.
//

import SwiftUI

struct DetailView: View {
    var launch: Launch 
    
    var body: some View {
        VStack {
            Image("rocket")
            Text(launch.name)
                .font(.system(size: 30, weight: .bold))
            if let detail = launch.details {
                Text(detail)
            } else {
                Text("The details for this launch are not available at the moment.")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(launch: .launchWithoutDetails)
        DetailView(launch: .launchWithDetails)
    }
}
