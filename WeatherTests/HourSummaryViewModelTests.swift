//
//  HourSummaryViewModelTests.swift
//  WeatherTests
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Weather

class HourSummaryViewModelTests: XCTestCase {
  var viewModel: HourSummaryViewModel!
  
  override func setUp() {
    self.viewModel = HourSummaryViewModel(hourSummary: WeatherSummary.createMock().hourly.first!)
  }
  
  func test_hourSummaryViewModel() {
    XCTAssertEqual(viewModel.tempFmt, "79º")
    XCTAssertEqual(viewModel.timeFmt, "11:00 AM")
    XCTAssertEqual(viewModel.icon, Image(systemName: "sun.max"))
  }
}
