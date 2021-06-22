//
//  ApiRouter.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

import Alamofire
import RxSwift

typealias tParameters = [String: String]
protocol ApiRouter: URLRequestConvertible {
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: tParameters? { get }
}

extension ApiRouter {
    func encodedWithQueryString() throws -> String? {
        var cs = CharacterSet.urlQueryAllowed
        cs.remove("+")
        
        var components = URLComponents(string: baseUrlString + path)
        components?.percentEncodedQuery = parameters?.map {
            $0.addingPercentEncoding(withAllowedCharacters: cs)!
                + "=" + ($1 as AnyObject).addingPercentEncoding(withAllowedCharacters: cs)!
        }.joined(separator: "&")
        
        return components?.string
    }
    
    func body(_ parameters: tParameters) throws -> Data? {
        return try? JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func asUrlRequest() throws -> URLRequest {
        let url = try baseUrlString.asURL().appendingPathComponent(path)
        var request = try URLRequest(url: url, method: method, headers: headers)
        
        if let params = parameters, params.count > 0 {
            switch method {
            case .get:
                request.url = try encodedWithQueryString()?.asURL()
            case .post:
                request.httpBody = try body(params)
            default:
                break
            }
        }
        
        return request
    }
    
    func request<T: Decodable>(_ typeOf: T.Type) -> Single<ApiResponse<T>> {
        return ApiService.shared.request(typeOf, self)
    }
}
