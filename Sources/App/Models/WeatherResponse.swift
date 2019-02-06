//
//  Weather.swift
//  App
//
//  Created by Chau Chin Yiu on 04.02.19.
//
import Vapor

struct WeatherResponse : Content {
 
    var coord: Coord
    var weather: [Weather]
    var main: MainInfo
}

struct Coord: Content  {
    var lon: Float
    var lat: Float
}
//"weather":[{"id":741,"main":"Fog","description":"fog","icon":"50d"}]
struct Weather: Content{
    var id: Int
    var main : String
    var description : String
    var icon : String
}
//"main": {"temp": -0.57,"pressure": 1027, "humidity": 92,"temp_min": -2,"temp_max": 0}
struct MainInfo: Content {
    var temp: Float
    var pressure : Int
    var humidity : Int
    var temp_min : Float
    var temp_max : Float
}
