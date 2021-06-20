//
//  ApiLogger.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

import Alamofire

class ApiLogger: EventMonitor {
    let queue = DispatchQueue(label: "APILOG")
    func requestDidResume(_ request: Request) {
        print("")
        debugPrint(request)
    }
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("")
        debugPrint(response)
    }
}
