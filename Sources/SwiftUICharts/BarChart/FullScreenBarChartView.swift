//
//  FullScreenBarChartView.swift
//
//
//  Created by Joshua Holme on 1/8/21.
//

import SwiftUI

public struct FullScreenBarChartView : View {
    var data: [Double]
    var accentColor: Color
    var secondaryColor: Color
    var gradient: GradientColor?
    var isStacked: Bool
    var maxValue: Double
    @State private var touchLocation: CGFloat = -1.0
    
    public init(data: [Double], accentColor: Color, secondaryColor: Color, gradient: GradientColor?, isStacked: Bool = false, touchLocation: CGFloat = -1.0) {
        self.data = data
        self.accentColor = accentColor
        self.secondaryColor = secondaryColor
        self.gradient = gradient
        self.isStacked = isStacked
        
        var tempMax: Double {
            guard let max = data.max() else {
                return 1
            }
            return max != 0 ? max : 1
        }
        
        self.maxValue = tempMax
    }
    
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width-22)/CGFloat(self.data.count * 3)){
                ForEach(0..<self.data.count, id: \.self) { i in
                    VStack {
                        BarChartCell(value: self.normalizedValue(index: i),
                                     secondBarValue: self.normalizedValue(index: i),
                                     index: i,
                                     width: Float(geometry.frame(in: .local).width - 22),
                                     numberOfDataPoints: self.data.count,
                                     accentColor: self.accentColor,
                                     secondAccentColor: self.secondaryColor,
                                     gradient: self.gradient,
                                     stacked: self.isStacked,
                                     touchLocation: self.$touchLocation)
                            .scaleEffect(self.touchLocation > CGFloat(i)/CGFloat(self.data.count) && self.touchLocation < CGFloat(i+1)/CGFloat(self.data.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                            .animation(.spring())
                        Text(String(UnicodeScalar(65 + i)!))
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        Text("\(Int(self.data[i]))")
                            .font(.title)
                    }
                }
            }
            .padding([.top, .leading, .trailing], 10)
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index])/Double(self.maxValue)
    }
}

//struct FullScreenBarChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenBarChartView()
//    }
//}
