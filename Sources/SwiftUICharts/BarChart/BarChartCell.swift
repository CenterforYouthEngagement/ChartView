//
//  ChartCell.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartCell : View {
    var value: Double
    var secondBarValue: Double
    var index: Int = 0
    var width: Float
    var numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 1.5)
    }
    var accentColor: Color
    var secondAccentColor: Color
    var gradient: GradientColor?
    var stacked: Bool

    
    @State var scaleValue: Double = 0
    @State var secondScaleValue: Double = 0
    @Binding var touchLocation: CGFloat
    public var body: some View {
        if stacked == false
        {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: accentColor, end: accentColor).getGradient(), startPoint: .bottom, endPoint: .top))
            }
            .frame(width: CGFloat(self.cellWidth))
            .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
            .onAppear(){
                self.scaleValue = self.value
            }
            .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
        }
        else {
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: secondAccentColor, end: secondAccentColor).getGradient(), startPoint: .bottom, endPoint: .top))
                    Rectangle()
                        .fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: accentColor, end: accentColor).getGradient(), startPoint: .bottom, endPoint: .top))
                }
            }
            .frame(width: CGFloat(self.cellWidth))
            .cornerRadius(4)
            .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
            .onAppear(){
                self.scaleValue = self.value
                self.secondScaleValue = self.value
            }
            .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
        }
    }
}

#if DEBUG
struct ChartCell_Previews : PreviewProvider {
    static var previews: some View {
        BarChartCell(value: Double(0.75), secondBarValue: Double(0.75), width: 320, numberOfDataPoints: 12, accentColor: Colors.OrangeStart, secondAccentColor: Colors.GradientUpperBlue, gradient: nil, stacked: true, touchLocation: .constant(-1))
    }
}
#endif
