//
//  FullScreenLineChart.swift
//  
//
//  Created by Joshua Holme on 2/9/21.
//

import SwiftUI

struct FullScreenLineChart: View {
    var data: [Double]
    var title: String
    var legend: String?
    var style: ChartStyle
    var rateValue: Int?
    var dropShadow: Bool?
    var valueSpecifier: String?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LineChartView(data: data, title: title, legend: legend, style: style, form: CGSize(width: geometry.frame(in: .local).width, height: geometry.frame(in: .local).height), rateValue: rateValue, dropShadow: dropShadow, valueSpecifier: valueSpecifier)
            }
        }
    }
}

//struct FullScreenLineChart_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenLineChart(data: <#[Double]#>, title: <#String#>, style: <#ChartStyle#>)
//    }
//}