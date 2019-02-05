//
//  WeatherController.swift
//  App
//
//  Created by Chau Chin Yiu on 04.02.19.
//

import Vapor

class WeatherController {
    
    
    func city(_ req: Request, name: String) throws -> Future<Response> {
        let client = try req.make(Client.self)
        
        
        let weatherResponse = client.get("https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=b50a8ebaff3e45413c6fe674489f5541&units=metric")
        
        let imagesResponse = client.get("https://api.unsplash.com/search/photos?page=1&query=\(name)&client_id=284ab250f4d0cd5fe2d1538ffa5d30a58d76e96fadfc90362d0a7aeb3191ef20")
        // Parsing Transforms the `Future<Response>` to `Future<ExampleData>`
        //        let exampleData = response.flatMap(to: ExampleData.self) { response in
        //            return response.content.decode(ExampleData.self)
        //        }
        return weatherResponse
//          return Weather()
    }
    
 
}
