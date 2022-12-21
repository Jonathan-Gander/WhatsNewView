//
//  WhatsNewView.swift
//  WhatsNewView
//
//  Created by Jonathan Gander
//
//  Contains WhatsNewView main view, and WhatsNewFeature object.
//

import SwiftUI

// MARK: - Feature
public struct WhatsNewFeature: Identifiable, Hashable {
    public let id = UUID()
    public let image: Image?
    public let title: String
    public let text: String
    
    public init(title: String, text: String, image: Image?) {
        self.title = title
        self.text = text
        if let image = image {
            self.image = image
        }
        else {
            // Default fallback image
            self.image = Image(systemName: "circle.hexagongrid.fill")
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - WhatsNewView
public struct WhatsNewView: View {
    
    private var features: [WhatsNewFeature]
    
    private var mainColor: Color
    private var titleText: String
    private var subtitleText: String?
    private var continueText: String?
    private var moreInfoText: String?
    
    // Closures on buttons tap
    private var continueButtonAction: (() -> Void)?
    private var moreInfoButtonAction: (() -> Void)?
    private var featureTapAction: ((WhatsNewFeature, Int) -> Void)? // params: tapped Feature, at index (from features array)
    
    // MARK: - Init
    public init(
        features: [WhatsNewFeature],
        
        mainColor: Color = .blue,
        titleText: String = "What's New",
        subtitleText: String? = "In this version", // Set to nil to hide this text
        continueText: String? = "Continue", // Set to nil to hide this button
        moreInfoText: String? = "More info", // Set to nil to hide this button
        
        continueButtonAction: (() -> Void)? = nil, // Action on Continue button
        moreInfoButtonAction: (() -> Void)? = nil, // Action on More info button
        featureTapAction: ((WhatsNewFeature, Int) -> Void)? = nil // Action on features tap, set to nil to disable tap on features
    ) {
        self.features = features
        self.mainColor = mainColor
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.continueText = continueText
        self.moreInfoText = moreInfoText
        
        self.continueButtonAction = continueButtonAction
        self.moreInfoButtonAction = moreInfoButtonAction
        self.featureTapAction = featureTapAction
    }
    
    // MARK: - UI
    public var body: some View {
        
        VStack {
            ScrollView(showsIndicators: false) {
                
                // Header (title + subtitle)
                WhatsNewHeaderView(title: titleText, subtitle: subtitleText)
                    .padding(.top)
                
                // Features list
                // Display them as button (if featureTapAction is set) or simple views
                if featureTapAction != nil {
                    ForEach(features) { feature in
                        Button {
                            if let index = features.firstIndex(of: feature) {
                                featureTapAction!(feature, index)
                            }
                        } label: {
                            WhatsNewFeatureView(title: feature.title, text: feature.text, image: feature.image, imageColor: mainColor)
                        }
                        .buttonStyle(.plain)
                    }
                }
                else {
                    ForEach(features) { feature in
                        WhatsNewFeatureView(title: feature.title, text: feature.text, image: feature.image, imageColor: mainColor)
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top)
            
            // Bottom buttons
            VStack {
                if let moreInfoText = moreInfoText {
                    Button(.init(moreInfoText)) {
                        if let moreInfoButtonAction = moreInfoButtonAction {
                            moreInfoButtonAction()
                        }
                    }
                    .font(.callout)
                    .foregroundColor(mainColor)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                }
                
                if let continueText = continueText {
                    Button(action: {
                        if let continueButtonAction = continueButtonAction {
                            continueButtonAction()
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text(.init(continueText))
                            Spacer()
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(mainColor)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.bottom)
        }
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView(features: [
            WhatsNewFeature(title: "App loads 42x faster", text: "Specially when you refresh your discussions list in the morning.", image: Image(systemName: "speedometer")),
            WhatsNewFeature(title: "Bugs fix", text: "Fix a lot of minor issues. Also add UI improvement in several views.", image: Image(systemName: "ant"))
        ])
    }
}
