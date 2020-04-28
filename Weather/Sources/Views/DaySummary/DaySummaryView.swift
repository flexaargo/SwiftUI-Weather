//
//  DaySummaryView.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import SwiftUI

struct DaySummaryView: View {
  private let viewModel: DaySummaryViewModel
  
  init(viewModel: DaySummaryViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack {
      Text(viewModel.day)
        .fontWeight(.medium)
      Spacer()
      Text("\(viewModel.highTempFmt) / \(viewModel.lowTempFmt)")
        .fontWeight(.light)
      viewModel.icon
        .imageScale(.large)
        .foregroundColor(.secondary)
    }.padding(.horizontal)
      .padding(.vertical, 22)
      .background(Color.init(.secondarySystemBackground))
      .cornerRadius(10)
  }
}

struct DaySummaryView_Previews: PreviewProvider {
  static var previews: some View {
    DaySummaryView(viewModel: DaySummaryViewModel(daySummary: WeatherSummary.createMock().daily.first!))
  }
}
