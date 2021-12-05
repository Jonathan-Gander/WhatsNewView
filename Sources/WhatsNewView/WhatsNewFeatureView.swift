//
//  WhatsNewFeatureView.swift
//  WhatsNewView
//
//  Created by Jonathan Gander
//
//  Display a feature with image, title and text
//

import SwiftUI

struct WhatsNewFeatureView: View {
    
    public var title: String
    public var text: String
    
    public var image: Image?
    public var imageColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:30, maxHeight: 30)
                    .foregroundColor(imageColor)
            }
            
            
            VStack (alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}
