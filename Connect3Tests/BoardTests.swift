//
//  BoardTests.swift
//  Connect3
//
//  Created by Jose Sanchez Rodriguez on 6/3/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import XCTest

@testable import Connect3
class BoardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test de inicialización del tablero
    func testCanInitializeBoard() {
        let board = Board()
        XCTAssertNotNil(board)
    }
    
    // Test de Después de añadir una ficha, está en su posición correcta
    func testAfterAddingCoinItsTheRightPosition() {
        var board = Board()
        
        // Red player
        board.playAt(col: 0, player: .Red)
        
        var player = board.playerAt(col: 0, row: 0)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        
        player = board.playerAt(col: 0, row: 1)
        XCTAssertEqual(player, .White)
    }
}
