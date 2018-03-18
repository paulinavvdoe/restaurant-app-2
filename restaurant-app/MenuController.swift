//
//  MenuController.swift
//  restaurant-app
//
//  Created by Paulina Van der Doe on 15/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import UIKit

class MenuController {
    
    // Import menucontroller function.
    static let shared = MenuController()
    
    // Set up base url from which the data will be imported.
    let baseURL = URL(string: "https://resto.mprog.nl/")!

    /// Go the the url where categories items are given and import them.
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        // Import data form .json file if possible.
        let task = URLSession.shared.dataTask(with: categoryURL) {
            (data, response, error) in
                if let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
                    let categories = jsonDictionary?["categories"] as? [String] {
                    completion(categories)
                } else {
                    completion(nil)
            }
        }
        task.resume()
    }

    /// Go to the URL where the menu items are given and import them.
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        // Store the menu data from the .json file.
        let task = URLSession.shared.dataTask(with: menuURL) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    /// Go to the URL for submitting order data.
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        
        // Send data to server using post request.
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        
        // Encode data to be send to json.
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try?
                    jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// Function to get the image from the server.
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
            let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// Function to upload the order and send info about preparation time to confirmation screen.
    func uploadOrder() {
        let menuIds = menuItems.map { $0.id }
        MenuController.shared.submitOrder(menuIds: menuIds)
        { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
}
