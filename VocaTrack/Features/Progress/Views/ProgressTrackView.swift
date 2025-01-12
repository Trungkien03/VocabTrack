//
//  ProgressView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Charts
import SwiftUI

struct ProgressTrackView: View {
    let progressData = [
        ("Jan 8", 10),
        ("Jan 9", 12),
        ("Jan 10", 8),
        ("Jan 11", 15),
        ("Jan 12", 20)
    ]

    var body: some View {
        VStack {
            Chart {
                ForEach(progressData, id: \.0) { date, count in
                    BarMark(x: .value("Date", date), y: .value("Words", count))
                }
            }
            .frame(height: 300)
            .padding()

            Spacer()
        }
        .navigationTitle("Progress Overview")
    }
}

#Preview {
    ProgressTrackView()
}
