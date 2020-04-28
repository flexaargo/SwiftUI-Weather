//
//  DataManager.swift
//  Weather
//
//  Created by Alex Fargo on 4/26/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

protocol WeatherFetcher {
  func weatherSummary(forCity city: String) -> AnyPublisher<WeatherSummary, WeatherError>
}

class DataManager {
  let session: URLSession
  
  init(session: URLSession = .init(configuration: .default)) {
    self.session = session
  }
}

extension DataManager: WeatherFetcher {
  func weatherSummary(forCity city: String) -> AnyPublisher<WeatherSummary, WeatherError> {
    getCoordinates(forAddressString: city)
      .flatMap { [weak self] coordinates -> AnyPublisher<URLSession.DataTaskPublisher.Output, WeatherError> in
        guard let self = self,
          let url = self.makeWeatherSummaryComponents(withCoordinates: coordinates).url else {
            return Fail(error: WeatherError.network(message: "Could not create URL"))
              .eraseToAnyPublisher()
        }
        return self.session.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { WeatherError.network(message: $0.localizedDescription) }
          .eraseToAnyPublisher()
      }.flatMap { pair in
        Just(pair.data)
          .decode(type: OneCallResponse.self, decoder: JSONDecoder())
          .mapError { error in
            WeatherError.parsing(message: error.localizedDescription)
          }.map { response in
            WeatherSummary.convert(fromResponse: response)
          }.eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
}

private extension DataManager {
  struct OpenWeatherAPI {
    static let scheme: String = "https"
    static let host: String = "api.openweathermap.org"
    static let path: String = "/data/2.5"
    static var key: String? {
      if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
        let dict = NSDictionary(contentsOfFile: path),
        let key = dict["openWeatherAPIKey"] as? String {
        return key
      }
      return nil
    }
  }
  
  func makeWeatherSummaryComponents(withCoordinates coordinates: CLLocationCoordinate2D) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenWeatherAPI.scheme
    components.host = OpenWeatherAPI.host
    components.path = OpenWeatherAPI.path + "/onecall"
    
    components.queryItems = [
      .init(name: "lat", value: "\(coordinates.latitude)"),
      .init(name: "lon", value: "\(coordinates.longitude)"),
      .init(name: "appid", value: OpenWeatherAPI.key)]
    
    return components
  }
  
  func getCoordinates(forAddressString addressString: String) -> AnyPublisher<CLLocationCoordinate2D, WeatherError> {
    let geocoder = CLGeocoder()
    return Future<CLLocationCoordinate2D, WeatherError> { promise in
      geocoder.geocodeAddressString(addressString) { placemarks, error in
        if let error = error {
          print(error)
          promise(.failure(WeatherError.location(message: error.localizedDescription)))
          return
        }
        guard let location = placemarks?.first?.location else {
          promise(.failure(WeatherError.location(message: "Could not find location for \(addressString)")))
          return
        }
        promise(.success(location.coordinate))
      }
    }.eraseToAnyPublisher()
  }
}
