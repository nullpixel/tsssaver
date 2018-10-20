//
//  API.swift
//
//  Created by AppleBetas on 2017-01-15.
//  Copyright © 2017 AppleBetas. All rights reserved.
//

import Foundation

class API {
    static let shared = API(baseURL: URL(string: "https://tsssaver.1conan.com")!)
    var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    enum HTTPMethod {
        case GET, DELETE, OPTIONS
        case POST([String: Any], ParameterEncoding), PUT([String: Any], ParameterEncoding)
        case POST_Text(String), PUT_Text(String)
        
        var description: String {
            switch self {
            case .GET:
                return "GET"
            case .POST(_), .POST_Text(_):
                return "POST"
            case .PUT(_), .PUT_Text(_):
                return "PUT"
            case .DELETE:
                return "DELETE"
            case .OPTIONS:
                return "OPTIONS"
            }
        }
        
        var body: Data? {
            switch self {
            case .POST(let dict, let encoding), .PUT(let dict, let encoding):
                return encoding.encode(body: dict)
            case .POST_Text(let body), .PUT_Text(let body):
                return body.data(using: .utf8)
            default:
                return nil
            }
        }
        
        var contentType: String? {
            switch self {
            case .POST(_, let encoding), .PUT(_, let encoding):
                return encoding.contentType
            case .POST_Text(_), .PUT_Text(_):
                return "text/plain; charset=utf-8"
            default:
                return nil
            }
        }
    }
    
    enum ParameterEncoding {
        case formURLEncoded, json
        
        func encode(body: [String: Any]) -> Data? {
            switch self {
            case .formURLEncoded:
                return APIUtilities.formURLParameterEncoded(body: body).data(using: .utf8)
            case .json:
                return try? JSONSerialization.data(withJSONObject: body)
            }
        }
        
        var contentType: String? {
            switch self {
            case .formURLEncoded:
                return "application/x-www-form-urlencoded; charset=utf-8"
            case .json:
                return "application/json; charset=utf-8"
            }
        }
    }
    
    func makeRequest(to endpoint: String, method: HTTPMethod = .GET, headers: [String: String] = [:],_ completionHandler: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.httpMethod = method.description
        request.httpBody = method.body
        request.addValue(API.userAgentString, forHTTPHeaderField: "User-Agent")
        if let contentType = method.contentType {
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        for (name, value) in headers {
            request.addValue(value, forHTTPHeaderField: name)
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data else { completionHandler(nil, error); return }
            completionHandler(data, error)
        })
        task.resume()
    }
    
    func makeJSONRequest(to endpoint: String, method: HTTPMethod = .GET, headers: [String: String] = [:],_ completionHandler: @escaping ([String: AnyObject]?, Error?) -> Void) {
        makeRequest(to: endpoint, method: method, headers: headers, { data, error in
            guard let data = data else { completionHandler(nil, error); return }
            completionHandler(self.decode(jsonData: data), error)
        })
    }
    
    func decode(jsonData: Data) -> [String: AnyObject]? {
        return (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) as? [String: AnyObject]
    }
    
    func decode(jsonString: String) -> [String: AnyObject]? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        return decode(jsonData: jsonData)
    }
    
    static var userAgentString: String {
        var userAgentString = "App"
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            userAgentString = bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            userAgentString = bundleName
        }
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            userAgentString += "/\(version)"
        }
        return userAgentString
    }
    
}

struct APIUtilities {
    static func formURLParameterEncoded(body: [String: Any]) -> String {
        var result = [String]()
        for (name, value) in body {
            if let nameEncoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let valueEncoded = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                result.append("\(nameEncoded)=\(valueEncoded)")
            }
        }
        let resultStr = result.joined(separator: "&")
        return resultStr
    }
}
