//
//  HourSummaryView.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import SwiftUI

struct HourSummaryView: View {
  private let viewModel: HourSummaryViewModel
  
  init(viewModel: HourSummaryViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 16) {
      Text(viewModel.tempFmt)
        .font(.caption)
        .fontWeight(.medium)
      viewModel.icon
        .imageScale(.large)
      Text(viewModel.timeFmt)
        .font(.caption)
        .fontWeight(.medium)
        .layoutPriority(1)
        .fixedSize()
    }.padding(10)
      .background(Color.init(.secondarySystemBackground))
      .cornerRadius(10)
  }
}

struct HourSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    HourSummaryView(viewModel: HourSummaryViewModel(hourSummary: WeatherSummary.createMock().hourly.first!))
  }
}
