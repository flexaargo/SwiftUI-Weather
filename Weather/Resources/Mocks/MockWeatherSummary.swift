//
//  MockWeatherSummary.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation

#if DEBUG
extension WeatherSummary {
  static func createMock() -> WeatherSummary {
    let path = Bundle.main.path(forResource: "MockOneCallResponse", ofType: "json")!
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    let response = try! JSONDecoder().decode(OneCallResponse.self, from: data)
    return WeatherSummary.convert(fromResponse: response)
  }
}
#endif
