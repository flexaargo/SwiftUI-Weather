//
//  WeatherSummaryView.swift
//  Weather
//
//  Created by Alex Fargo on 4/26/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import SwiftUI

struct WeatherSummaryView: View {
  @ObservedObject var viewModel: WeatherSummaryViewModel
  
  init(viewModel: WeatherSummaryViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      Color(.systemBackground)
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 32) {
        SearchBar(searchText: $viewModel.searchText, placeholder: "Search for a location")
        currentWeatherView
        viewModel.todayInformationViewModel() != nil ?
          CurrentSummaryView(viewModel: viewModel.todayInformationViewModel()!) : nil
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(viewModel.hourSummaries) { viewModel in
              HourSummaryView(viewModel: viewModel)
            }
          }
        }
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            ForEach(viewModel.daySummaries) { viewModel in
              DaySummaryView(viewModel: viewModel)
            }
          }
        }
      }.padding([.horizontal])
        .padding(.top)
    }.onTapGesture {
      UIApplication.shared.endEditing()
    }
  }
  
  private var currentWeatherView: some View {
    if let _ = viewModel.weatherSummary {
      return AnyView(HStack {
        VStack(spacing: 4) {
          Text(viewModel.currentTempDescription)
            .font(.headline)
            .fontWeight(.medium)
          HStack {
            viewModel.currentWeatherIcon
              .imageScale(.small)
            Text("\(viewModel.currentTempFmt)")
              .fontWeight(.semibold)
          }.font(.system(size: 64))
            .frame(maxWidth: .infinity)
          HStack(spacing: 16) {
            Text("Feels like \(viewModel.feelsLikeTempFmt)")
              .foregroundColor(.secondary)
          }
        }
      })
    } else {
      return AnyView(EmptyView())
    }
  }
}

struct WeatherSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherSummaryView(viewModel: WeatherSummaryViewModel(weatherFetcher: MockWeatherFetcher()))
  }
}
