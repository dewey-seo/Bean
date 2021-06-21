//
//  ApiRequest.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

import Alamofire
import RxSwift

class ApiService {
    static var shared: ApiService = ApiService()
    static func request<T: Decodable>(_ router: ApiRouter) -> Single<ApiResponse<T>> {
        return Single.create { (single) in
            shared.session
                .request(router)
                .validate(statusCode: 200..<401)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let model):
                        single(.success(ApiResponse<T>(model)))
                    case .failure(let err):
                        single(.failure(err))
                    }
                }
            return Disposables.create()
        }
        
    }
    
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])
    let monitors: [EventMonitor] = [ApiLogger()]
    let session: Session
    
    private init() {
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
