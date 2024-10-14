//
//  ExerciseGraphView.swift
//  GymApp
//
//  Created by Martin Novak on 03.10.2024..
//

import SwiftUI
import Charts

struct ExerciseGraphView: View {
    var graphData: [ExerciseGraphData]
    var exerciseName: String

    var body: some View {
        VStack {
            Text(exerciseName)
                .font(.headline)
                .padding()

            Chart {
                ForEach(graphData, id: \.date) { data in
                    BarMark(
                        x: .value("Date", data.date),
                        y: .value("Weight", data.weight)
                    )
                    .foregroundStyle(.blue)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) {
                    AxisValueLabel(format: .dateTime.year().month().day())
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisValueLabel()
                }
            }
            .frame(height: 300)
        }
    }
}
