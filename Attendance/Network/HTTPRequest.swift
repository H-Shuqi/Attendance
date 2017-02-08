//
//  HRequest.swift
//  Component
//
//  Created by 胡舒琦 on 16/11/15.
//  Copyright © 2016年 胡舒琦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private extension String {
    /// 去首尾空格
    ///
    /// - Returns: String
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}

/// HTTP请求对象
open class HTTPRequest : NSObject {
    public typealias ErrorHandler = (Error!) -> Swift.Void
    public typealias ProgressHandler = (Progress!)->Void
    
    public typealias HTTPMethod = Alamofire.HTTPMethod
    
    private var url:String!
    private var method:HTTPMethod = .get
    private var param:Dictionary<String, Any>?
    private var heanders:HTTPHeaders!
    private var errorHandler:ErrorHandler?
    
    private var progress:Progress?
    private var progressHandler:ProgressHandler?
    
    private init(url:String!, method:HTTPMethod) {
        self.url = NETWORK.SERVER_ADDRESS + url
        self.method = method
        self.heanders = [
            "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Upgrade-Insecure-Requests":"1",
            "User-Agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 10_2 like Mac OS X) AppleWebKit/602.3.12 (KHTML, like Gecko) Mobile/14C92 MicroMessenger/6.5.3 NetType/WIFI Language/zh_CN",
            "Accept-Language":"zh-cn",
            "Accept-Encoding":"gzip, deflate",
            "Connection":"keep-alive"
        ]
    }
    
    
    /// 初始化请求
    ///
    /// 请求类型: GET
    ///
    /// - Parameter url: 请求地址
    public convenience init(_ url:String){
        self.init(url:url, method:HTTPMethod.get)
    }
    
    
    /// 初始化请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - method: 请求类型
    public convenience init(_ url: String, method:HTTPMethod){
        self.init(url:url, method:method)
    }
    
    
    /// 设置Cookie
    ///
    /// - Parameter cookie: 包含在Resquest Heander中的Cookie参数
    open func cookies(_ cookie:Dictionary<String,String>) -> HTTPRequest {
        if(cookie.count > 0){
            var tmpArr:Array<String> = Array<String>()
            for (key,value) in cookie {
                tmpArr.append(key+"="+value)
            }
            self.heanders["Cookie"] = tmpArr.joined(separator: ";")
        }
        return self
    }
    
    /// 设置请求参数
    ///
    /// - Parameter param: 请求参数
    open func parameters(_ param:Dictionary<String, Any>) -> HTTPRequest {
        self.param = param
        return self
    }
    
    
    /// 设置请求管理类
    private var Manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            NETWORK.SERVER_ADDRESS: .disableEvaluation,
        ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return manager
    }()
    
    
    /// 发起请求
    ///
    /// - Parameter completionHandler: 请求成功回调
    @discardableResult open func response(_ completionHandler: @escaping(HTTPResponse!) -> Swift.Void ) -> HTTPRequest {
        self.Manager.delegate.taskWillPerformHTTPRedirection = {(session:URLSession, task:URLSessionTask, response:HTTPURLResponse, request:URLRequest) in
            return nil
        }

        let request:DataRequest = self.Manager.request(self.url, method:self.method, parameters:self.param, headers:self.heanders)
        self.progress = request.progress
        self.progress!.addObserver(self, forKeyPath: "completedUnitCount", options: NSKeyValueObservingOptions.new, context: nil)
        request.response { (afResponse) in
            if afResponse.error == nil && afResponse.data != nil {
                completionHandler(HTTPResponse(afResponse))
            } else {
                if(self.errorHandler != nil){
                    self.errorHandler!(afResponse.error ?? HError(-10, "网络异常"))
                }
            }
        }
        return self
    }
    
    /// 设置异常回调
    ///
    /// - Parameter errorHandler: 请求失败回调
    @discardableResult open func error(_ errorHandler:@escaping ErrorHandler) -> HTTPRequest {
        self.errorHandler = errorHandler
        return self
    }
    
    
    /// 进度返回进度
    ///
    /// - Parameter progressHandler: 进度回调
    @discardableResult open func progress(_ progressHandler:@escaping (Progress?) -> Swift.Void) -> HTTPRequest {
        self.progressHandler = progressHandler
        return self
    }
    
    
    /// 请求进度回调
    ///
    /// - Parameters:
    ///   - keyPath: 监听路径
    ///   - object: 监听对象
    ///   - change: 变化
    ///   - context: UnsafeMutableRawPointer
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(self.progressHandler != nil){
            self.progressHandler!(object as! Progress)
        }
    }
    
    deinit{
        if (self.progress != nil) {
            self.progress?.removeObserver(self, forKeyPath: "completedUnitCount")
        }
    }
    
}


/// HTTP响应对象
open class HTTPResponse {
    
    /// 响应头
    private(set) var heanders:[String: Any] = Dictionary<String, Any>()
    
    /// 响应体
    private(set) var body:String
    
    /// 响应体JSON格式数据
    var jsonData:JSON? {
        get {
            return JSON(self.body)
        }
    }
    
    /// Cookie
    var cookies:[String: String] {
        get {
            var cookie = [String: String]()
            if let cookies:String = self.heanders["Set-Cookie"] as! String? {
                let semicolonArray:[String] = cookies.components(separatedBy: ";")
                var commaArray:[String] = [String]()
                for semicolonItem in semicolonArray {
                    let commaTmpArray:[String] = semicolonItem.components(separatedBy: ",")
                    commaArray.append(contentsOf: commaTmpArray)
                }
                for commaItem in commaArray {
                    let itemArr = commaItem.components(separatedBy: "=")
                    cookie[itemArr.first!.trim()] = itemArr.last!.trim()
                }
            }
            return cookie
        }
    }
    
    fileprivate init(_ response:Alamofire.DefaultDataResponse) {
        for (key, value) in (response.response?.allHeaderFields)! {
            self.heanders[key.base as! String] = value as! String
        }
        self.body = response.data != nil ? String(data:response.data!, encoding:.utf8) ?? "" : ""
    }
}
