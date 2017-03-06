//
//  Board.swift
//  Connect3
//
//  Created by Jose Sanchez Rodriguez on 6/3/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

enum Player {
    case Red
    case White
    case Empty
}

// (red, red, white, empty)
// Columna con los jugadores empezando desde abajo
struct Board {
    
    //MARK: - Typealias
    typealias BoardColumn = [Player]
    
    //MARK: - Properties
    static let width = 5 // Ancho
    static let height = 5 // Alto
    
    var _board : [BoardColumn]


    //MARK: - Initialization
    init() {
        // Create the 5x5 board
        _board = [[.Empty, .Empty, .Empty, .Empty, .Empty],
                  [.Empty, .Empty, .Empty, .Empty, .Empty],
                  [.Empty, .Empty, .Empty, .Empty, .Empty],
                  [.Empty, .Empty, .Empty, .Empty, .Empty],
                  [.Empty, .Empty, .Empty, .Empty, .Empty]]
    }
    
    // Función que establece un jugador en la primera posición libre
    // Si no hay posiciones libres, no hace nada
    mutating func playAt(col: Int, player: Player) {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return
        }
        
        let column = _board[col]
        
        // Se asigna el jugador en la primera posición libre (Empty)
        for (index, currentPlayer) in column.enumerated() {
            if currentPlayer == .Empty {
                // Se mete la ficha
                _board[col][index] = player
                break
            }
        }
    }
    
    func playerAt(col: Int, row: Int) -> Player {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return .Empty
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return .Empty
        }
        
        // Se retorna la posición
        return _board[col][row]
    }
}
