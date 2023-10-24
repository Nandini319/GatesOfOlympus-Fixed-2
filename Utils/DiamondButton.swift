//
//  DiamondButton.swift
//  Gates of Olympus
//
//  Created by Nandini Vithlani on 13/10/23.
//

import SwiftUI

struct DiamondButton: View {
    let label: String
    
    var body: some View {
        ZStack {
            DiamondShape()
                .fill(Color.clear)
            
            Image("button")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 330, height: 150)
            Text(label)
                .font(.custom("Georgia", size: 25))
                .foregroundColor(Color.charcoalGray)
                .position(x: 165, y: 65)
        }
        .frame(width: 140, height: 100)
    }
}


struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width, y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: CGPoint(x: 0, y: height / 2))
        path.closeSubpath()
        
        return path
    }
}

