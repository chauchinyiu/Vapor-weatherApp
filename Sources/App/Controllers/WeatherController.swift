//
//  WeatherController.swift
//  App
//
//  Created by Chau Chin Yiu on 04.02.19.
//

import Vapor
import Foundation

class WeatherController {
    
    typealias WeatherRequestCompletionHandler = (_ result: WeatherResponse?, _ error: Error?)-> Void
    typealias ImageRequestCompletionHandler = (_ result:ImageResponse?, _ error: Error?)-> Void

    func city(_ req: Request, name: String) throws -> Future<Response> {
        
        
        let client = try req.make(Client.self)
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.requestImage(client, name) { (imageResponse, error) in
            guard let image = imageResponse, error == nil else {
                 dispatchGroup.leave()
                return
            }
            print(image)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.requestWeather(client, name) { (weatherResponse, error) in
            guard let weather = weatherResponse, error == nil else {
                dispatchGroup.leave()
                return
            }
            print(weather)
            dispatchGroup.leave()
        }
        
       dispatchGroup.wait()
   
       print("Both functions complete 👍")
        let response = client.get("https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=b50a8ebaff3e45413c6fe674489f5541&units=metric")
            
       return response
 
    }
    
    func requestWeather(_ client: Client,_ name: String, completionHandler: @escaping WeatherRequestCompletionHandler ){
        let response = client.get("https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=b50a8ebaff3e45413c6fe674489f5541&units=metric")
        
        let weatherResponse:Future<WeatherResponse> = response.flatMap{try $0.content.decode(WeatherResponse.self)}
        
        weatherResponse.do { weather in
             completionHandler(weather,nil)
            }.catch { error in
                print(error) // A Swift Error
              completionHandler(nil,error)
        }
    }

    
    func requestImage(_ client: Client, _ name: String, completionHandler: @escaping ImageRequestCompletionHandler ){
        let response = client.get("https://api.unsplash.com/search/photos?page=1&query=\(name)&client_id=284ab250f4d0cd5fe2d1538ffa5d30a58d76e96fadfc90362d0a7aeb3191ef20")
        
        
        let imageResponse = response.flatMap{try $0.content.decode(ImageResponse.self)}
        
        imageResponse.do { image in
            completionHandler(image,nil)
            }.catch { error in
                print(error) // A Swift Error
                completionHandler(nil,error)
        }
    }

}


