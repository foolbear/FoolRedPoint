# FoolRedPoint

Simple RedPoint for SwiftUI.

## Installation: 
Swift package Manager   
 
## Usage:  
 
### state 
```
public enum FoolRedPointState: Int, CustomStringConvertible {
    case hide
    case show
    case blink
}
```
### show red point 
change the state through $redPointState1 @State value 
```
View.foolRedPoint(state: $redPointState1, size: CGSize(width: 20, height: 10), alignment: .bottomLeading) { Capsule().fill(Color.red) }
```
### sample code 
FoolRedPointTestView.swift  
```
public struct FoolRedPointTestView: View {
    @State private var redPointState1: FoolRedPointState = .show
    @State private var redPointState2: FoolRedPointState = .blink
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            VStack {
                Rectangle()
                    .foregroundColor(Color.blue.opacity(0.3))
                    .frame(width: 120, height: 100)
                    .foolRedPoint(state: $redPointState1)
                    .foolRedPoint(state: $redPointState1, size: CGSize(width: 20, height: 10), alignment: .bottomLeading) { Capsule().fill(Color.red) }
                    .foolRedPoint(state: $redPointState2, alignment: .topTrailing, redPoint: { Circle().fill(Color.red) })
                    .foolRedPoint(state: $redPointState2, alignment: .bottomTrailing) { Circle().fill(Color.red).offset(x: -20, y: -10) }
                    .padding()
                HStack {
                    VStack {
                        Button(action: {
                            self.redPointState1 = .hide
                        }) {
                            Text("Hide")
                        }
                        .padding()
                        Button(action: {
                            self.redPointState1 = .show
                        }) {
                            Text("Show")
                        }
                        .padding()
                        Button(action: {
                            self.redPointState1 = .blink
                        }) {
                            Text("Blink")
                        }
                        .padding()
                    }
                    .padding()
                    VStack {
                        Button(action: {
                            self.redPointState2 = .hide
                        }) {
                            Text("Hide")
                        }
                        .padding()
                        Button(action: {
                            self.redPointState2 = .show
                        }) {
                            Text("Show")
                        }
                        .padding()
                        Button(action: {
                            self.redPointState2 = .blink
                        }) {
                            Text("Blink")
                        }
                        .padding()
                    }
                }
                Spacer()
            }
        }
    }
}
```

