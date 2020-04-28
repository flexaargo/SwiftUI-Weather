//
//  HourSummaryViewModel.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation
import SwiftUI

class HourSummaryViewModel: Identifiable {
  private let hourSummary: HourlyWeatherSummary
  
  var id = UUID()
  
  var tempFmt: String {
    String(format: "%.0fº", hourSummary.actualTemp.fahrenheight)
  }
  
  var icon: Image? {
    hourSummary.weatherDetails.first?.weatherIcon
  }
  
  var timeFmt: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:00 a"
    return dateFormatter.string(from: hourSummary.time)
  }
  
  init(hourSummary: HourlyWeatherSummary) {
    self.hourSummary = hourSummary
  }
}
