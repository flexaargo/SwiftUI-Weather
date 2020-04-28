//
//  WeatherSummaryViewModel.swift
//  Weather
//
//  Created by Alex Fargo on 4/26/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import SwiftUI
import Combine

class WeatherSummaryViewModel: ObservableObject {
  private var weatherFetcher: WeatherFetcher
  private var disposable = Set<AnyCancellable>()
  
  @Published var searchText: String = "Cupertino"
  @Published var weatherSummary: WeatherSummary?
  
  var currentTempFmt: String {
    guard let temp = weatherSummary?.current.actualTemp.fahrenheight else { return "--º" }
    return String(format: "%.0fº", temp)
  }
  
  var feelsLikeTempFmt: String {
    guard let temp = weatherSummary?.current.feelsLikeTemp.fahrenheight else { return "--º" }
    return String(format: "%.0fº", temp)
  }
  
  var currentTempDescription: String {
    guard let description = weatherSummary?.current.weatherDetails.first?.weatherDescription else {
      return ""
    }
    return description.localizedCapitalized
  }
  
  var currentWeatherIcon: Image? {
    weatherSummary?.current.weatherDetails.first?.weatherIcon
  }
  
  var hourSummaries: [HourSummaryViewModel] = []
  var daySummaries: [DaySummaryViewModel] = []
  
  init(weatherFetcher: WeatherFetcher) {
    self.weatherFetcher = weatherFetcher
    
    let searchTextScheduler: DispatchQueue = .init(label: "weatherSearch", qos: .userInteractive)
    $searchText
      .dropFirst()
      .debounce(for: .seconds(0.5),
                scheduler: searchTextScheduler)
      .sink(receiveValue: fetchWeatherSummary(forLocation:))
      .store(in: &disposable)
    
    fetchWeatherSummary(forLocation: searchText)
  }
  
  func fetchWeatherSummary(forLocation location: String) {
    weatherFetcher.weatherSummary(forCity: location)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] (value) in
        switch value {
        case .failure(let error):
          self?.weatherSummary = nil
          self?.hourSummaries = []
          self?.daySummaries = []
          print(error)
        case .finished:
          break
        }
      }) { [weak self] weatherSummary in
        self?.weatherSummary = weatherSummary
        self?.hourSummaries = weatherSummary.hourly.map { HourSummaryViewModel(hourSummary: $0) }
        self?.daySummaries = weatherSummary.daily.map { DaySummaryViewModel(daySummary: $0) }
    }.store(in: &disposable)
  }
  
  func todayInformationViewModel() -> CurrentSummaryViewModel? {
    guard let weatherSummary = weatherSummary else { return nil }
    return .init(weatherSummary: weatherSummary.current)
  }
}
