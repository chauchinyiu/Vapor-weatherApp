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
        
   
        let response = client.get("https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=b50a8ebaff3e45413c6fe674489f5541&units=metric")
       
        let weatherResponse:Future<WeatherResponse> = response.flatMap{try $0.content.decode(WeatherResponse.self)}
        
        weatherResponse.do { weather in
            guard let detail = weather.weather.first else {
               return
            }
            
            print(detail.main + "," + detail.description)
        
         }.catch { error in
                    print(error) // A Swift Error
          }
        
        
       let imagesResponse = client.get("https://api.unsplash.com/search/photos?page=1&query=\(name)&client_id=284ab250f4d0cd5fe2d1538ffa5d30a58d76e96fadfc90362d0a7aeb3191ef20")
 
        return response

    }
    
 
}
