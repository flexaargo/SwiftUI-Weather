//
//  DaySummaryViewModel.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation
import SwiftUI

class DaySummaryViewModel: Identifiable {
  private let daySummary: DailyWeatherSummary
  
  var id = UUID()
  
  var day: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: daySummary.time)
  }
  
  var highTempFmt: String {
    String(format: "%.0fº", daySummary.maxTemp.fahrenheight)
  }
  
  var lowTempFmt: String {
    String(format: "%.0fº", daySummary.minTemp.fahrenheight)
  }
  
  var icon: Image? {
    daySummary.weatherDetails.first?.weatherIcon
  }
  
  init(daySummary: DailyWeatherSummary) {
    self.daySummary = daySummary
  }
}
