//
//  SequenceTest.swift
//  Connect3
//
//  Created by Jose Sanchez Rodriguez on 7/3/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import XCTest

class SequenceTest: XCTestCase {
    
    func testMap() {
        // Map transforma arrays
        let original = [1,2,3,4]
        let result = [2,3,4,5]
        
        XCTAssertEqual(result, original.map{$0 + 1})
    }
    
    func testFlatMao() {
        // FlatMap aplasta y luego mapea arrays
        let original = [[1], [2,3],[4]]
        let result = [2,3,4,5]
        
        XCTAssertEqual(result, original.flatMap{$0}.map{$0 + 1})
    }
}
