//
//  DaySummaryViewModelTests.swift
//  WeatherTests
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Weather

class DaySummaryViewModelTests: XCTestCase {
  var viewModel: DaySummaryViewModel!
  
  override func setUp() {
    viewModel = DaySummaryViewModel(daySummary: WeatherSummary.createMock().daily.first!)
  }
  
  func test_daySummaryViewModel() {
    XCTAssertEqual(viewModel.day, "Monday")
    XCTAssertEqual(viewModel.lowTempFmt, "72º")
    XCTAssertEqual(viewModel.highTempFmt, "82º")
    XCTAssertEqual(viewModel.icon, Image(systemName: "sun.max"))
  }
}
