//
//  HTTPClient.swift
//  TaskList
//
//  Created by jpcm2 on 22/02/23.
//

import Foundation

enum HttpError: Error{
        case badURL, badResponse, errorDecondigData, invalidURL
}

enum HttpMethods: String{
    case POST, GET, PUT, DELETE
}

enum MIMEType: String{
    case JSON = "application/json"
}

enum HttpHeaders: String{
    case contentType = "Content-Type"
}
class HTTpClient{
    private init() {}
    
    static let shared = HTTpClient()
    
    func fetch<T: Codable>(url: URL) async throws -> [T]{
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else{
            return []
        }
        
        return object
    }
    
    func sendData<T: Codable>(url: URL, object: T, httpMethod: String) async throws{
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
    
    func deleteTask(url: URL, httpMethod: String) async throws{
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
