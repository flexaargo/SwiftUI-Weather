//
//  OneCallResponse.swift
//  Weather
//
//  Created by Alex Fargo on 4/26/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//
//  This file was generated from JSON Schema using quicktype, do not modify it directly.
//  To parse the JSON, add this file to your project and do:
//
//   let oneCallResponse = try? newJSONDecoder().decode(OneCallResponse.self, from: jsonData)

import Foundation

// MARK: - OneCallResponse
struct OneCallResponse: Codable {
  let lat, lon: Double
  let timezone: String
  let current: CurrentResponse
  let hourly: [HourlyResponse]
  let daily: [DailyResponse]
}

// MARK: - CurrentResponse
struct CurrentResponse: Codable {
  let dt, sunrise, sunset: Int
  let temp, feelsLike: Double
  let pressure, humidity: Int
  let uvi: Double
  let clouds, visibility: Int?
  let windSpeed: Double
  let windDeg: Int
  let weather: [WeatherResponse]
  let rain: RainResponse?
  
  enum CodingKeys: String, CodingKey {
    case dt, sunrise, sunset, temp
    case feelsLike = "feels_like"
    case pressure, humidity, uvi, clouds, visibility
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case weather, rain
  }
}

// MARK: - RainResponse
struct RainResponse: Codable {
  let the1H: Double?
  
  enum CodingKeys: String, CodingKey {
    case the1H = "1h"
  }
}

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}

// MARK: - DailyResponse
struct DailyResponse: Codable {
  let dt, sunrise, sunset: Int
  let temp: TempResponse
  let feelsLike: FeelsLikeResponse
  let pressure, humidity: Int
  let windSpeed: Double
  let windDeg: Int
  let weather: [WeatherResponse]
  let clouds: Int
  let rain: Double?
  let uvi: Double
  
  enum CodingKeys: String, CodingKey {
    case dt, sunrise, sunset, temp
    case feelsLike = "feels_like"
    case pressure, humidity
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case weather, clouds, rain, uvi
  }
}

// MARK: - FeelsLikeResponse
struct FeelsLikeResponse: Codable {
  let day, night, eve, morn: Double
}

// MARK: - TempResponse
struct TempResponse: Codable {
  let day, min, max, night: Double
  let eve, morn: Double
}

// MARK: - HourlyResponse
struct HourlyResponse: Codable {
  let dt: Int
  let temp, feelsLike: Double
  let pressure, humidity, clouds: Int
  let windSpeed: Double
  let windDeg: Int
  let weather: [WeatherResponse]
  let rain: RainResponse?
  
  enum CodingKeys: String, CodingKey {
    case dt, temp
    case feelsLike = "feels_like"
    case pressure, humidity, clouds
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case weather, rain
  }
}
