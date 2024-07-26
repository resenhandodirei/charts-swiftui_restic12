//
//  ContentView.swift
//  charts_swiftui
//
//  Created by Larissa Martins Correa on 24/07/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    enum TimeFilter: String, CaseIterable, Identifiable {
        case monthly = "Monthly"
        case quarterly = "Quarterly"
        case yearly = "Yearly"
        
        var id: String { self.rawValue }
        
        
    }
    
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 55000),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 45000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 35000),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 25000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 15000),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 5000)
    ]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Helper Desk calls")
            
            Text("Total: \(viewMonths.reduce(0, { $0 + $1.viewCount}))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                RuleMark(y: .value("Goal", 30000))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount)
                    )
                    .foregroundStyle(Color.pink.gradient)
                    
                }
            }
            .frame(height: 180)
            .chartXAxis {
                AxisMarks(values: viewMonths.map { $0.date }) { date in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                    
                }
            }
            .chartYAxis {
                AxisMarks { mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
            }
            //            .chartXAxis(.hidden)
            .chartYScale(domain: 0...30000)
            
            //            .chartPlotStyle { plotContent in
            //                plotContent
            //                    .background(.black.gradient.opacity(0.3))
            //                    .border(.green, width: 3)
            //            }
        }
        .padding()
    }
    
    private func applyFilter() {
            // Filter logic based on `selectedFilter`
            switch selectedFilter {
            case .monthly:
                filteredViewMonths = allViewMonths
            case .quarterly:
                // Example: Filter by quarters
                filteredViewMonths = allViewMonths.filter { month in
                    let monthNumber = Calendar.current.component(.month, from: month.date)
                    return monthNumber % 3 == 1
                }
            case .yearly:
                // Example: Filter by year
                filteredViewMonths = allViewMonths.filter { month in
                    Calendar.current.component(.year, from: month.date) == 2023
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
    
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}


#Preview {
    ContentView()
}

