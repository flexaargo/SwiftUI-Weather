//
//  WeatherSummaryViewModelTests.swift
//  WeatherTests
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Weather

class WeatherSummaryViewModelTests: XCTestCase {
  var viewModel: WeatherSummaryViewModel!
  
  override func setUp() {
    viewModel = WeatherSummaryViewModel(weatherFetcher: MockWeatherFetcher())
  }
  
  func test_WeatherSummaryViewModel() {
    viewModel.searchText = "test"
    RunLoop.main.run(mode: .default, before: .distantPast)
    XCTAssertEqual(viewModel.currentTempFmt, "79º")
    XCTAssertEqual(viewModel.feelsLikeTempFmt, "79º")
    XCTAssertEqual(viewModel.currentTempDescription, "Clear Sky")
    XCTAssertEqual(viewModel.currentWeatherIcon, Image(systemName: "sun.max"))
    
    XCTAssertEqual(viewModel.hourSummaries.count, 48)
    XCTAssertEqual(viewModel.daySummaries.count, 8)
  }
}
