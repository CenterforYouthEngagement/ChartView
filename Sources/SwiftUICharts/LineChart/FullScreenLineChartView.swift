//
//  FullScreenLineChartView.swift
//
//
//  Created by Joshua Holme on 2/9/21.
//

import SwiftUI

struct FullScreenLineChartView: View {
    var data: [Double]
    var title: String
    var legend: String?
    var style: ChartStyle
    var rateValue: Int?
    var dropShadow: Bool?
    var valueSpecifier: String?
    
    public init(data: [Double], title: String, legend: String?, style: ChartStyle, rateValue: Int?, dropShadow: Bool?, valueSpecifier: String?) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.rateValue = rateValue
        self.dropShadow = dropShadow
        self.valueSpecifier = valueSpecifier
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LineChartView(data: data, title: title, legend: legend, style: style, form: CGSize(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height), rateValue: rateValue, dropShadow: dropShadow, valueSpecifier: valueSpecifier)
            }
        }
    }
}

//struct FullScreenLineChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenLineChartView(data: <#[Double]#>, title: <#String#>, style: <#ChartStyle#>)
//    }
//}
