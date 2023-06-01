//
//  EventTests.swift
//  polypolyTests
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import XCTest
@testable import polypoly

class EventTests: XCTestCase {

    func testInvoke() {
        // Arrange
        var result = ""
        let event = Event<String>()
        let handler1 = { (data: String) in
            result = "Handler 1 called with data: \(data)"
        }
        let handler2 = { (data: String) in
            result = "Handler 1 called with data: \(data)"
        }

        // Act
        event += handler1
        event.Invoke(data: "hello Event")
        XCTAssertEqual(result, "Handler 1 called with data: hello Event")
        
        event.AddHandler(handler: handler2)
        event.Invoke(data: "Hello, world!")
        XCTAssertEqual(result, "Handler 1 called with data: Hello, world!")
    
        
    }
    func test2Parameters(){
        let event = Event<(String, Int)>()
        var result = ""

        let handler2 = { (data: (String, Int)) in
            result = "Handler 1 called with data: \(data)"
        }
        
        event += { (data: (String, Int)) in
            result = "Handler 1 called with data: \(data)"
        }
        
        event.Invoke(data: ("hello Event", 1))
        XCTAssertEqual(result, "Handler 1 called with data: (\"hello Event\", 1)")
        
        event.AddHandler(handler: handler2)
        event.Invoke(data: ("Hello, world!", 2))
        XCTAssertEqual(result, "Handler 1 called with data: (\"Hello, world!\", 2)")
    }
}

