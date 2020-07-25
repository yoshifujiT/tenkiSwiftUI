//
//  ContentView.swift
//  MaybeCloudy
//
//  Created by ToruYoshifuji on 2020/07/04.
//  Copyright © 2020 ToruYoshifuji. All rights reserved.
//

import SwiftUI

struct WeatherListView: View {
    @ObservedObject private var weatherListVM = WeatherListViewModel()
    
    func getCityItem(cityId: Int) -> CityData {
        let cityItem = cityData.first(where: { $0.id == cityId})!
        return cityItem
    }

    var body: some View {
        ZStack {
            Color("Gray01")
                .edgesIgnoringSafeArea(.all)
    
            VStack(spacing: 0) {
                AppBar()
                NavigationView {
                    GeometryReader { geometry in
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(self.weatherListVM.weatherData) { weather in
                                    // TODO: ここでローカル変数cityを宣言してdestinationとRowで使いたい
                                    NavigationLink(
                                        destination: WeatherDetailView(
                                            weather: weather,
                                            city: self.getCityItem(cityId: weather.id)
                                        )
                                    ) {
                                        WeatherListRow(
                                            weather: weather,
                                            city: self.getCityItem(cityId: weather.id)
                                        )
                                    }
                                    Rectangle()
                                        .fill(Color("Gray02"))
                                        .frame(height: 1)
                                }
                            }
                            .padding(.horizontal, 16)
                            .frame(width: geometry.size.width)
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    }
                }
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(16)
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
