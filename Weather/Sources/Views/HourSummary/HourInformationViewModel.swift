//
//  HourSummaryViewModel.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation

class HourSummaryViewModel: Identifiable {
  private let hourSummary: HourlyWeatherSummary
  
  var id = UUID()
  
  init(hourSummary: HourlyWeatherSummary) {
    self.hourSummary = hourSummary
  }
}
