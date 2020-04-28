//
//  CurrentSummaryViewModel.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation

class CurrentSummaryViewModel {
  private let currentSummary: CurrentWeatherSummary
  
  var sunriseTimeFmt: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: currentSummary.sunriseTime)
  }
  
  var sunsetTimeFmt: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: currentSummary.sunsetTime)
  }
  
  var windSpeed: String {
    let kmh = currentSummary.windSpeed
    let mph = kmh / 1.609
    return String(format: "%.0f mi/h", mph)
  }
  
  var windDirection: String {
    currentSummary.windDirection
  }
  
  var uvIndex: String {
    String(format: "%.0f", currentSummary.uvIndex)
  }
  
  var humidity: String {
    "\(currentSummary.humidity)%"
  }
  
  init(weatherSummary: CurrentWeatherSummary) {
    self.currentSummary = weatherSummary
  }
}
