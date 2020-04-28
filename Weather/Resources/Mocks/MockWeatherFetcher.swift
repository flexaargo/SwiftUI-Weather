//
//  MockWeatherFetcher.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation
import Combine

class MockWeatherFetcher: WeatherFetcher {
  func weatherSummary(forCity city: String) -> AnyPublisher<WeatherSummary, WeatherError> {
    return Just(WeatherSummary.createMock())
      .setFailureType(to: WeatherError.self)
      .eraseToAnyPublisher()
  }
}
