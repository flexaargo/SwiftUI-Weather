//
//  CurrentSummaryViewModelTests.swift
//  WeatherTests
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Weather

class CurrentSummaryViewModelTests: XCTestCase {
  var viewModel: CurrentSummaryViewModel!
  
  override func setUp() {
    viewModel = CurrentSummaryViewModel(weatherSummary: WeatherSummary.createMock().current)
  }
  
  func test_currentSummaryViewModel() {
    XCTAssertEqual(viewModel.sunriseTimeFmt, "6:06 AM")
    XCTAssertEqual(viewModel.sunsetTimeFmt, "7:33 PM")
    XCTAssertEqual(viewModel.windSpeed, "1 mi/h")
    XCTAssertEqual(viewModel.windDirection, "S")
    XCTAssertEqual(viewModel.uvIndex, "10")
    XCTAssertEqual(viewModel.humidity, "53%")
  }
}
