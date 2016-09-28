//
//  Observable+Extensions.swift
//  Tasks
//
//  Created by 和泉田 領一 on 2016/09/29.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import Foundation
import RxSwift
import Swiftz

public protocol OptionalType {
    
    associatedtype Wrapped

    var optional: Wrapped? { get }
    
}

extension Optional: OptionalType {
    
    public var optional: Wrapped? {
        return self
    }
    
}

public extension ObservableType {

    public func ignoreValue() -> Observable<()> {
        return self.map {
            _ in
            return ()
        }
    }
    
    public func replace<T>(_ object: T) -> Observable<T> {
        return self.map { _ in
            return object
        }
    }
    
}

public extension ObservableType where E: OptionalType {

    public func ignoreNil() -> Observable<E.Wrapped> {
        return self.flatMap {
            element -> Observable<E.Wrapped> in
            guard let value = element.optional else {
                return Observable<E.Wrapped>.empty()
            }
            return Observable<E.Wrapped>.just(value)
        }
    }

}
