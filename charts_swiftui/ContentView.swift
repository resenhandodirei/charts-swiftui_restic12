//
//  ContentView.swift
//  charts_swiftui
//
//  Created by Larissa Martins Correa on 24/07/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 55000),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 45000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 35000),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 25000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 15000),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 5000)
    ]
    
    
    var body: some View {
        VStack {
            Chart {
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount)
                    )
                }
            }
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

