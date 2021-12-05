# A nice way to present your new app features (in SwiftUI)

`WhatsNewView` is a Swift Package for SwiftUI that lets you present to your users your app new features in a pretty way (see screenshots below). For example, when you have released an update and you want to explain what is new.

It is really easy to use and to add to your app. It only takes an array of `WhatsNewFeature` (features to present) as mandatory parameter. All other parameters are here to customize visual aspect and interactions.


If you're using UIKit in your project, have a look on [Jonathan-Gander/WhatsNewViewController](https://github.com/Jonathan-Gander/WhatsNewViewController).

## Features

- Title and subtitle
- List of all features with image, title, text
- A Continue button (hiddable)
- A More info button (hiddable)
- Change main color (with light/dark mode)
- Vertical and horizontal orientation
- Methods to handle user interactions


## Usage

### Installation

Add `WhatsNewView` package to your project. 

In Xcode 13.1: `File` -> `Add Packages...` then enter my project GitHub URL:  
`https://github.com/Jonathan-Gander/WhatsNewView`

### Quick start

In file you want to display `WhatsNewView`:

```swift
import WhatsNewView
```

Then create a `WhatsNewView` by passing your `WhatsNewFeature` array. You can also customize your view UI and interaction with other optional parameters.

Details about each parameter:

- `features`: Array of `WhatsNewFeature` to display
- `mainColor`: Tint color for features images, Continue button and More info button
- `titleText`: View title
- `subtitleText`: View subtitle. Set to `nil` to hide subtitle.
- `continueText`: Text for Continue button. Set to `nil` to hide Continue button.
- `MoreInfoText`: Text for More info button. Set to `nil` to hide More info button.
- `continueButtonAction`: Function called when Continue button is tapped.
- `moreInfoButtonAction`: Function called when More info button is tapped.
- `featureTapAction`: Function called when a feature is tapped. It takes two parameters: tapped feature, and feature index (in `features` array). Set to `nil` so `features` are not buttons (just views).

### Complete example

Here is as example of a view displaying a `WhatsNewView` as a sheet.

```swift
struct ContentView: View {
    @State private var showView = false
    @State private var outputText = ""

    private let features = [
        WhatsNewFeature(title: "First amazing feature", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan pretium arcu, sit amet porta lectus ultrices sed.", image: Image(systemName: "paintbrush")),
        WhatsNewFeature(title: "Second feature", text: "Sed lacinia tortor nunc, at eleifend mi porta eu.", image: Image(systemName: "globe.europe.africa.fill")),
        WhatsNewFeature(title: "Another one", text: "Sed ex risus, vehicula et finibus et, venenatis vitae nisi.", image: Image(systemName: "megaphone")),
    ]
    
    var body: some View {
        NavigationView {
            
            VStack {
                Button("Display WhatsNewView") {
                    outputText = ""
                    showView.toggle()
                }
                .font(.headline)
                
                .sheet(isPresented: $showView) {
                    WhatsNewView(
                        features: features,
                        mainColor: .green,
                        titleText: "What's New",
                        subtitleText: "In version 1.42",
                        continueText: "Continue",
                        moreInfoText: "More info...",
                        continueButtonAction: whatsNewContinue,
                        moreInfoButtonAction: whatsNewMoreInfo,
                        featureTapAction: whatsNewDidTap(feature:atIndex:)
                    )
                }
                    
                Text(outputText)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding()
            
            }
            
            .navigationTitle("WhatsNewView demo")
        }
    }
    
    func whatsNewContinue() {
        outputText = "Continue button tapped"
        showView.toggle()
    }
    
    func whatsNewMoreInfo() {
        outputText = "More info button tapped"
        showView.toggle()
    }
    
    func whatsNewDidTap(feature: WhatsNewFeature, atIndex index: Int) {
        outputText = "Feature at index \(index) tapped: \(feature.title)"
        showView.toggle()
    }
}
```

## Screenshots

Here are few screenshots (with random texts!) of `WhatsNewView`:

![Simulator Screen Shot - iPhone 12 - 2021-12-05 at 17 19 44](https://user-images.githubusercontent.com/1695222/144754570-b8f77b31-3140-48e3-bd25-d5ef3d41c1a7.png)
![Simulator Screen Shot - iPhone 12 - 2021-12-05 at 17 21 15](https://user-images.githubusercontent.com/1695222/144754589-085ed154-f22f-4fb3-b1e7-80480ba57fba.png)

![Simulator Screen Shot - iPhone 12 - 2021-12-05 at 17 22 00](https://user-images.githubusercontent.com/1695222/144754613-9cdc5e4e-9326-4765-97d1-83b212ad215d.png)
![Simulator Screen Shot - iPhone 12 - 2021-12-05 at 17 23 01](https://user-images.githubusercontent.com/1695222/144754643-37da1eae-9ab8-4d06-b92b-d01ddfb86db5.png)


## They're already using it

If you use it in your app, please let me know and I will add your link here. You can [contact me here](https://contact.gander.family?locale=en).

## Licence

Be free to use this `WhatsNewView` package in your app. Licence is available [here](https://github.com/Jonathan-Gander/WhatsNewView/blob/main/LICENSE). Please only add a copyright and licence notice.
