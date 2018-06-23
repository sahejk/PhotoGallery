//
//  VehiclesViewController.swift
//  assignment
//
//  Created by Sahej Kaur on 07/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

public typealias JSONObject = [String : Any]

public enum ReturnError : Error {
  case apiError(code: String, header: String?, message: String?)
  case invalidJSON
}

public enum Result<T> {
  case success(result: T)
  case failure(error: Error)
}

public enum ValidationError: Error {
  case missing(String)
  case invalid(String, Any)
}

public enum Content<T> {
  case empty
  case success(value: T)
}


protocol RestInterface {
  func get(path: String, query: String?, headers: [String: String]?, completion:@escaping (JSONObject) -> Void);
}

open class Rest: NSObject, RestInterface {
  public enum HTTPMethod: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
  }
  
  public enum APIURLs: String {
    case baseUrl = "https://api.flickr.com/services/rest/"
  }
  
  /// Make a REST connection
  internal func connect(method: String,
                        path: String,
                        query: String? = nil,
                        headers: [String: String]? = nil,
                        jsonObject: JSONObject? = nil,
                        completion: @escaping (JSONObject) -> Void) throws {
    let apiURL = APIURLs.baseUrl.rawValue
    guard  var components = URLComponents(string: apiURL) else {
      throw ValidationError.invalid("baseURL", apiURL)
    }
    components.path += path
    if let validQuery = query, !validQuery.isEmpty {
      components.query = validQuery
    }
    guard let url = components.url else {
      throw ValidationError.invalid("path", components.path)
    }
    
    
    // Setup Request
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
    request.httpMethod = method
    request.allHTTPHeaderFields = headers
    request.timeoutInterval = 30
    
    // Setup JSON
    if let jsonObject = jsonObject {
      guard JSONSerialization.isValidJSONObject(jsonObject) else {
        print("Invalid JSON Object: \(jsonObject)")
        throw ValidationError.invalid("jsonObject", jsonObject)
      }
      
      let jsonData = try JSONSerialization.data(withJSONObject: jsonObject,
                                                options: [])
      request.setValue("application/json", forHTTPHeaderField: "content-type")
      request.httpBody = jsonData
    }
    let urlSession: URLSession = URLSession.shared
    
    // Make the call
    urlSession.dataTask(with: request, completionHandler: { data, response, error in
      DispatchQueue.main.async {
        do {
          // Check response errors
          if let responseError = error { throw responseError }
          
          let jsonObject = try self.validJson(from: data)
          
          // Successful result
          completion(jsonObject)
          
        } catch {
          print("Rest Error: \(error.localizedDescription)")
          completion([:])
        }
      }
      
    }).resume()
    
  }
  
  // MARK: - Public methods
  
  func get(path: String, query: String? = nil, headers: [String: String]? = nil, completion:@escaping (JSONObject) -> Void) {
    do {
      try connect(method: HTTPMethod.get.rawValue, path: path, query: query,
                  headers: headers, jsonObject: nil, completion: completion)
    } catch {
      completion([:])
    }
  }
}

public protocol JSONValidation {
  func validJson(from data: Data?) throws -> JSONObject
}



extension Rest : JSONValidation {
  public func validJson(from data: Data?) throws -> JSONObject {
    guard let responseData = data else {
      throw ReturnError.invalidJSON
    }
    // Convert JSON data to Swift JSON Object
    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: [])
    guard let jsonObject = responseJson as? JSONObject else {
      throw ReturnError.invalidJSON
    }
    return jsonObject
  }
}



