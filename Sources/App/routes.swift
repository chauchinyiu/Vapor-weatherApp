import Vapor
import HTTP

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
   let weatherController = WeatherController()
    router.get("city", String.parameter) { req -> Future<Response> in
        let name = try req.parameters.next(String.self)
        let response = try weatherController.city(req, name: name)
        return response
    }
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
