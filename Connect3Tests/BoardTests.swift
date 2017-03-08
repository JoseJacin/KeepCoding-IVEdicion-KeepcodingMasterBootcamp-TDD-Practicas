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
    func testFullColumn_DoesnAcceptNewCoins() {
        // Red player
        board.playAt(col: 0, player: .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        
        let alreadyFullBoard : Board! = board
        
        // White player
        board.playAt(col: 0, player: .White)
        
        XCTAssertEqual(board,alreadyFullBoard)
    }
    
    // Test de validación de que dos Boards son iguales (y la aserción inversa)
    func test2EqualBoards_areEqual() {
        // Empty board
        let emptyBoard: Board! = board
        XCTAssertEqual(emptyBoard, board)
        
        // Some non-empty board
        var board2: Board! = board
        
        board.playAt(col: 0, player: .Red)
        board2.playAt(col: 0, player: .Red)
        
        XCTAssertEqual(board2, board)
        
        // Se comprueba la aserción inversa
        XCTAssertNotEqual(emptyBoard, board)
        XCTAssertNotEqual(emptyBoard, board2)
        
        board2.playAt(col: 3, player: .White)
        XCTAssertNotEqual(board, board2)
    }
    
    // Test de validación de que el Hash de dos Boards son iguales (y la aserción inversa)
    func testEqualBoards_haveSameHash() {
        // Caso vacío
        var board2 : Board! = board
        
        XCTAssertEqual(board2.hashValue, board.hashValue)
        
        // Caso con jugadas
        board.playAt(col: 2, player: .Red)
        board2?.playAt(col: 2, player: .Red)
        
        XCTAssertEqual(board2.hashValue, board.hashValue)
        
        // Inversa
        board2?.playAt(col: 3, player: .White)
        
        XCTAssertNotEqual(board2.hashValue, board.hashValue)
    }
    
    // Test para comprobar que no se puede añadir nada fuera de los rangos
    func testPlayOutOfBounds_isNOP() {
        let oldBoard : Board! = board
        
        board.playAt(col: Board.width+9, player: .Red)
        XCTAssertEqual(board, oldBoard)
        
        board.playAt(col: -42, player: .White)
        XCTAssertEqual(board, oldBoard)
    }
    
    // Test para comprobar que se ha ganado en una columna
    func testBoardWith3InColumn_isAWin() {
        // Column 0
        // Red player
        board.playAt(col: 0, player: .Red)
        
        // White player
        board.playAt(col: 0, player: .White)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        
        // White player
        board.playAt(col: 0, player: .Red)
        
        // Red player
        board.playAt(col: 0, player: .Red)
        
        let r = Connect3Rules(board: board)
        XCTAssertEqual(r.winner(), .Red)
        XCTAssertNotEqual(r.winner(), .White)
        XCTAssertNotEqual(r.winner(), .Empty)
        
//        XCTAssertEqual(board.playerWinnerInAColumnFromRow(col: 1, row: 4, player: .White), true)
//        XCTAssertEqual(board.playerWinnerInAColumnFromRow(col: 1, row: 3, player: .White), false)
//        XCTAssertEqual(board.playerWinnerInAColumnFromRow(col: 0, row: 4, player: .White), false)
//        XCTAssertEqual(board.playerWinnerInAColumnFromRow(col: 2, row: 4, player: .White), false)
//        XCTAssertEqual(board.playerWinnerInAColumn(col: 1, player: .White), true)
//        XCTAssertEqual(board.playerWinnerInAColumn(col: 2, player: .White), false)
//        XCTAssertEqual(board.winnerInAColumn(col: 1), .White)
//        XCTAssertEqual(board.winnerInAColumn(col: 2), .Empty)
    }
    
    // Test para comprobar que se ha ganado en una fila
    func testForAWinInARow() {
        // Column 0
        // Red player
        board.playAt(col: 0, player: .Red)
        
        // White player
        board.playAt(col: 1, player: .White)
        
        // Red player
        board.playAt(col: 2, player: .Red)
        
        // White player
        board.playAt(col: 3, player: .White)
        
        // Red player
        board.playAt(col: 4, player: .Red)
        
        // Column 1
        // Red player
        board.playAt(col: 0, player: .Red)
        
        // Red player
        board.playAt(col: 1, player: .Red)
        
        // White player
        board.playAt(col: 2, player: .White)
        
        // White player
        board.playAt(col: 3, player: .White)
        
        // White player
        board.playAt(col: 4, player: .White)
        
        XCTAssertEqual(board.playerWinnerInARowFromColumn(col: 4, row: 1, player: .White), true)
        XCTAssertEqual(board.playerWinnerInARowFromColumn(col: 1, row: 3, player: .White), false)
        XCTAssertEqual(board.playerWinnerInARowFromColumn(col: 0, row: 4, player: .White), false)
        XCTAssertEqual(board.playerWinnerInARowFromColumn(col: 2, row: 4, player: .White), false)
        //XCTAssertEqual(board.playerWinnerInARow(row: 2, player: .White), true)
        XCTAssertEqual(board.playerWinnerInARow(row: 1, player: .White), false)
        //XCTAssertEqual(board.winnerInARow(row: 1), .White)
        XCTAssertEqual(board.winnerInARow(row: 1), .Empty)
    }
    
    // Test para comprobar que el Board es vacío
    func testBoardWithEmptyPosition_isOccupiedByEmptyPlayer() {
        XCTAssertEqual(board.playerAt(col: 0, row: 0), .Empty)
        XCTAssertEqual(board.playerAt(col: 1, row: 2), .Empty)
        XCTAssertEqual(board.playerAt(col: 3, row: 4), .Empty)
    }
    
    // Test para comprobar que el Board NO es vacío
    func testBoardWithPlayerPosition_hasPositionOccupiedByPlayer() {
        // White
        board.playAt(col: 0, player: .White)
        XCTAssertEqual(board.playerAt(col: 0, row: 0), .White)
        
        board.playAt(col: 1, player: .White)
        XCTAssertEqual(board.playerAt(col: 1, row: 0), .White)
        
        board.playAt(col: 2, player: .White)
        XCTAssertEqual(board.playerAt(col: 2, row: 0), .White)
        
        // Red
        board.playAt(col: 0, player: .Red)
        XCTAssertEqual(board.playerAt(col: 0, row: 1), .Red)
        
        board.playAt(col: 1, player: .Red)
        XCTAssertEqual(board.playerAt(col: 1, row: 1), .Red)
        
        board.playAt(col: 2, player: .Red)
        XCTAssertEqual(board.playerAt(col: 2, row: 1), .Red)
    }
    
    
    
    
    func testTranspondedBoard_Ok() {
        // Empty board
        let board2: Board! = board
        XCTAssertEqual(board2, board)
        
        // Some non-empty board
        //var boardTransponsed: Board! = board2.prueba()
       
//        XCTAssertNotEqual(board2.hashValue, boardTranspose.hashValue)
    }
}
