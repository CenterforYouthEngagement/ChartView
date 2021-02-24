//
//  FullScreenLineChartView.swift
//
//
//  Created by Joshua Holme on 2/9/21.
//

import SwiftUI

public struct FullScreenLineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var data:ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle

    public var dropShadow: Bool
    public var valueSpecifier:String
    
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    private var rateValue: Int?
    
    public init(data: [Double],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                rateValue: Int? = nil,
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f") {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.rateValue = rateValue
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 8){
                    Text(self.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    if (self.legend != nil){
                        Text(self.legend!)
                            .font(.title)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor :self.style.legendTextColor)
                    }
                    HStack {
                        
                        if (self.rateValue ?? 0 != 0)
                        {
                            if (self.rateValue ?? 0 >= 0){
                                Image(systemName: "arrow.up")
                            }else{
                                Image(systemName: "arrow.down")
                            }
                            Text("\(self.rateValue!)%")
                        }
                    }
                }
                .padding([.leading, .top])
                Spacer()
                GeometryReader{ innerGeometry in
                    Line(data: self.data,
                         frame: .constant(innerGeometry.frame(in: .local)),
                         touchLocation: self.$touchLocation,
                         showIndicator: self.$showIndicatorDot,
                         minDataValue: .constant(nil),
                         maxDataValue: .constant(nil)
                    )
                }
                .frame(width: geometry.frame(in: .local).width, height: (geometry.frame(in: .local).height / 2) * 1.5)
            }.frame(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height)
        }
    }
}

//struct FullScreenLineChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenLineChartView(data: <#[Double]#>, title: <#String#>, style: <#ChartStyle#>)
//    }
//}
