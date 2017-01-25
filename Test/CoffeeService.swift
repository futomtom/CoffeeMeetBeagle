//
//  coffeeService.swift
//  Test
//
//  Created by Alex on 1/19/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

enum JSONResult {
    case success([Person])
    case failure(Error)
}


class CoffeeService {
    
    private static  var urlCache:URLCache = {
        let capacity = 10 * 1024 * 1024 // MBs
        let urlCache = URLCache(memoryCapacity: capacity, diskCapacity: capacity, diskPath: nil)
        return urlCache
    }()
    
    
    private static  var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        config.urlCache = urlCache
        return URLSession(configuration: config)
    }()
    
    
    class func downloadAvatar(_ imageURL: String,completion: @escaping (_: UIImage) -> Void) {
        let request = URLRequest(url: URL(string: imageURL)!)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard let data = data else {
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(UIImage())
            }
            
        }
        task.resume()
    }

    
    

    class func getPeople(completion: @escaping (_: [Person]) -> Void)  {
        let path = Bundle.main.path(forResource: "team", ofType: "json")!
        let data = NSData(contentsOfFile: path)
        var people = [Person]()

        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data as! Data, options: [])

            let jsonData = jsonObject as? [[String: Any]]
            for subJSON in jsonData! {
                let person = Person(fromJSON: subJSON)
                people.append(person)
            }
            completion(people)
        } catch {
            completion(people)
        }
    }

}
