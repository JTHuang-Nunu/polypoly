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
        event.AddHandler(handler: handler1)
        event.Invoke(data: "hello Event")
        XCTAssertEqual(result, "Handler 1 called with data: hello Event")
        
        event.AddHandler(handler: handler2)
        event.Invoke(data: "Hello, world!")
        XCTAssertEqual(result, "Handler 1 called with data: Hello, world!")
    
        
    }

    func testAddHandler() {
        // Arrange
        let event = Event<String>()
        let handler1 = { (data: String) in
            print("Handler 1 called with data: \(data)")
        }
        let handler2 = { (data: String) in
            print("Handler 2 called with data: \(data)")
        }

        // Act
        event.AddHandler(handler: handler1)
        event.AddHandler(handler: handler2)

        // Assert

    }

    func testOperatorAddition() {
        // Arrange
        let event1 = Event<String>()
        let event2 = Event<String>()
        let handler1 = { (data: String) in
            print("Handler 1 called with data: \(data)")
        }



    }
}

