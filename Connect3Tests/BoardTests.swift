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
    
    var board : Board!
    var player : Player!
    
    override func setUp() {
        super.setUp()
        
        board = Board()
        player = .Empty
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test de inicialización del tablero
    func testCanInitializeBoard() {
        XCTAssertNotNil(board)
    }
    
    // Test de Después de añadir una ficha, está en su posición correcta
    func testAfterAddingCoinItsTheRightPosition() {
        
        // Red player
        board.playAt(col: 0, player: .Red)
        
        player = board.playerAt(col: 0, row: 0)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        
        player = board.playerAt(col: 0, row: 1)
        XCTAssertEqual(player, .White)
    }
    
    // Test de que la posición es Empty
    func testThatAPlayerPositionIsEmpty() {
        XCTAssertEqual(board.playerAt(col: 0, row: 0), .Empty)
    }
    
    // Test de que la posición NO es Empty
    func testThatAPlayerPositionIsNotEmpty() {
        // Red player
        board.playAt(col: 0, player: .Red)
        XCTAssertNotEqual(board.playerAt(col: 0, row: 0), .Empty)
    }
    
    // Test de que la columna no cambia de estado cuando se añade una ficha en una columna llena
    func testNotChangeStatusWhenAddedInAFullColumn() {
        
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 0)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        player = board.playerAt(col: 0, row: 1)
        XCTAssertEqual(player, .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 2)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        player = board.playerAt(col: 0, row: 3)
        XCTAssertEqual(player, .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 4)
        XCTAssertEqual(player, .Red)
        
        let column : Board = board
        
        // White player
        board.playAt(col: 0, player: .White)
        
        for index in 0..<(Board.height) {
            XCTAssertEqual(board.playerAt(col: 0, row: index),column.playerAt(col: 0, row: index))
        }
    }
    
    // Test para comprobar que se ha ganado en una columna
    func testForAWinInAColumn() {
        
        // Column 0
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 0)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        player = board.playerAt(col: 0, row: 1)
        XCTAssertEqual(player, .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 2)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        player = board.playerAt(col: 0, row: 3)
        XCTAssertEqual(player, .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 4)
        XCTAssertEqual(player, .Red)
        
        // Column 1
        // Red player
        board.playAt(col: 1, player: .Red)
        player = board.playerAt(col: 1, row: 0)
        XCTAssertEqual(player, .Red)
        
        // Red player
        board.playAt(col: 1, player: .Red)
        player = board.playerAt(col: 1, row: 1)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 1, player: .White)
        player = board.playerAt(col: 1, row: 2)
        XCTAssertEqual(player, .White)
        
        // White player
        board.playAt(col: 1, player: .White)
        player = board.playerAt(col: 1, row: 3)
        XCTAssertEqual(player, .White)
        
        // White player
        board.playAt(col: 1, player: .White)
        player = board.playerAt(col: 1, row: 4)
        XCTAssertEqual(player, .White)
        
        XCTAssertEqual(board.winInAColumn(col: 1, row: 4, player: .White), true)
        XCTAssertEqual(board.winInAColumn(col: 1, row: 3, player: .White), false)
        XCTAssertEqual(board.winInAColumn(col: 0, row: 4, player: .White), false)
        XCTAssertEqual(board.winInAColumn(col: 2, row: 4, player: .White), false)
    }
    
    // Test para comprobar que se ha ganado en una columna
    func testForAWinInARow() {
        
        // Column 0
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 0)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 1, player: .White)
        player = board.playerAt(col: 1, row: 0)
        XCTAssertEqual(player, .White)
        
        // Red player
        board.playAt(col: 2, player: .Red)
        player = board.playerAt(col: 2, row: 0)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 3, player: .White)
        player = board.playerAt(col: 3, row: 0)
        XCTAssertEqual(player, .White)
        
        // Red player
        board.playAt(col: 4, player: .Red)
        player = board.playerAt(col: 4, row: 0)
        XCTAssertEqual(player, .Red)
        
        // Column 1
        // Red player
        board.playAt(col: 0, player: .Red)
        player = board.playerAt(col: 0, row: 1)
        XCTAssertEqual(player, .Red)
        
        // Red player
        board.playAt(col: 1, player: .Red)
        player = board.playerAt(col: 1, row: 1)
        XCTAssertEqual(player, .Red)
        
        // White player
        board.playAt(col: 2, player: .White)
        player = board.playerAt(col: 2, row: 1)
        XCTAssertEqual(player, .White)
        
        // White player
        board.playAt(col: 3, player: .White)
        player = board.playerAt(col: 3, row: 1)
        XCTAssertEqual(player, .White)
        
        // White player
        board.playAt(col: 4, player: .White)
        player = board.playerAt(col: 4, row: 1)
        XCTAssertEqual(player, .White)
        
        XCTAssertEqual(board.winInARow(col: 4, row: 1, player: .White), true)
        XCTAssertEqual(board.winInAColumn(col: 1, row: 3, player: .White), false)
        XCTAssertEqual(board.winInAColumn(col: 0, row: 4, player: .White), false)
        XCTAssertEqual(board.winInAColumn(col: 2, row: 4, player: .White), false)
    }
}
