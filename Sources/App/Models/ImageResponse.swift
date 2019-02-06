//
//  ImageResponse.swift
//  App
//
//  Created by Chinyiu Chau on 06.02.19.
//

import Vapor

struct ImageResponse: Content {
    var results: [Image]

}

struct Image : Content {
    var id: String
    var urls: Url
    var description: String
}

struct Url: Content {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}
