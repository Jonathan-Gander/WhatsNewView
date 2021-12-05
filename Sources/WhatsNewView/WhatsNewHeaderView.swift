//
//  WhatsNewHeaderView.swift
//  WhatsNewView
//
//  Created by Jonathan Gander
//
//  Display WhatsNewView's header with title and subtitle
//

import SwiftUI

struct WhatsNewHeaderView: View {
    
    public var title: String
    public var subtitle: String?
    
    var body: some View {
        
        VStack {
            Text(title)
                .font(.custom("Helvetica Neue", size: 34))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.bottom, 5)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.bottom, 40)
        
    }
}
