//
//  CurrentSummaryView.swift
//  Weather
//
//  Created by Alex Fargo on 4/27/20.
//  Copyright © 2020 Alex Fargo. All rights reserved.
//

import SwiftUI

struct CurrentSummaryView: View {
  private let viewModel: CurrentSummaryViewModel
  
  init(viewModel: CurrentSummaryViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      ZStack {
        HStack {
          VStack(alignment: .leading) {
            detailView(text: viewModel.sunriseTimeFmt,
                       image: .init(systemName: "sunrise"),
                       offset: .init(width: 0, height: -2))
            
            detailView(text: viewModel.sunsetTimeFmt,
                       image: .init(systemName: "sunset"),
                       offset: .init(width: 0, height: -2))
          }
          Spacer()
        }
        VStack(alignment: .leading) {
          detailView(text: "UV: \(viewModel.uvIndex)",
                     image: .init(systemName: "sun.max"))
          
          detailView(text: viewModel.humidity,
                     image: .init(systemName: "thermometer.sun"))
        }
        
        HStack {
          Spacer()
          VStack(alignment: .leading) {
            detailView(text: viewModel.windSpeed,
                       image: .init(systemName: "wind"))
            
            detailView(text: viewModel.windDirection,
                       image: .init(systemName: "arrow.up.right.circle"))
          }
        }
      }
    }
  }
  
  private func detailView(text: String, image: Image, offset: CGSize = .zero) -> some View {
    HStack {
      image
        .imageScale(.medium)
        .foregroundColor(.blue)
        .offset(offset)
      Text(text)
    }
  }
}


struct TodayInformationView_Previews: PreviewProvider {
  static var previews: some View {
    CurrentSummaryView(viewModel: .init(weatherSummary: WeatherSummary.createMock().current))
  }
}
