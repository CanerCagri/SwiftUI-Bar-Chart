//
//  ContentView.swift
//  SwiftUI-Bar-Chart
//
//  Created by Caner Çağrı on 10.04.2023.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 60000),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 122000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 67000),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 44000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 111000),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 61000),
        .init(date: Date.from(year: 2023, month: 7, day: 1), viewCount: 101000),
        .init(date: Date.from(year: 2023, month: 8, day: 1), viewCount: 50000),
        .init(date: Date.from(year: 2023, month: 9, day: 1), viewCount: 144000),
        .init(date: Date.from(year: 2023, month: 10, day: 1), viewCount: 58000),
        .init(date: Date.from(year: 2023, month: 11, day: 1), viewCount: 99000),
        .init(date: Date.from(year: 2023, month: 12, day: 1), viewCount: 78000)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Twitch Views")
            
            Text("Total: \(viewMonths.reduce(0, { $0 + $1.viewCount}))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {

                RuleMark(y: .value("Goal", 80000))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                    }
                
                ForEach(viewMonths) { viewMonth in
                    BarMark (
                        x: .value("Months", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount)
                    )
                    .foregroundStyle(Color.pink.gradient)
                }
            }
            .frame(height: 200)
//            .chartXAxis(.hidden)
//            .chartYScale(domain: 0...200000)
            .chartXAxis {
                AxisMarks(values: viewMonths.map { $0.date}) { date in
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                }
            }
            
            //MARK: We can change background color, border etc.
//            .chartPlotStyle { plotContent in
//                plotContent
//                    .background(.black.gradient.opacity(0.3))
//                    .border(.blue, width: 3)
//            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewMonth: Identifiable {
    var id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
