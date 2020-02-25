//
//  Weather.swift
//  WeatherApp
//
//  Created by Sebastian Tleye on 22/02/2020.
//  Copyright © 2020 HumileAnts. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {

    let temp: Double?
    let humidity: Double?

    static var placeHolder: Weather {
        return Weather(temp: nil, humidity: nil)
    }

}
