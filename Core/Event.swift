//
//  Event.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation

class Event<T> {

    typealias EventHandler = (T) -> ()
    var eventHandlers = [EventHandler]()
    func Invoke(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }
    func AddHandler(handler: @escaping EventHandler) {
        eventHandlers.append(handler)
    }
    public static func += <T> (left: Event<T>, right: @escaping (T) -> ()) {
        left.AddHandler(handler: right)
    }
}
