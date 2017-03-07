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
    static let numberOfChipsToWin = 3
    
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
    
    // Función que retorna si el jugador ha ganado en una columna
    func winInAColumn (col: Int, row: Int, player: Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return .Empty
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return .Empty
        }
        
        var countPlayer = 0
        var currentPlayer = player
        
        if row < 2 {
            return false
        }
        
        for index in (0...row).reversed() {
             currentPlayer = playerAt(col: col, row: index)
            if currentPlayer == player {
                countPlayer += 1
                
                if countPlayer == numberOfChipsToWin {
                    return true
                }
            } else {
                return false
            }
        }
        return false
    }
    
    // Función que retorna si el jugador ha ganado en una columna
    func winInARow (col: Int, row: Int, player: Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return .Empty
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return .Empty
        }
        
        var countPlayer = 0
  
        // Se valida hacia la izquierda
        for index in (col...Board.width).reversed() {
            if playerAt(col: index, row: row) == player {
                countPlayer = countPlayer + 1
                
                if countPlayer == numberOfChipsToWin {
                    return true
                }
            } else {
                break
            }
        }
        
        // Se valida hacia la derecha
        for index in col...Board.width {
            if playerAt(col: index, row: row) == player {
                countPlayer = countPlayer + 1
                
                if countPlayer == numberOfChipsToWin {
                    return true
                }
            } else {
                break
            }
        }
        
        return false
    }
    
    // Función que retorna si el jugador ha ganado en una columna
    func tie () -> Bool {
        // Llamar en bucle a winInAColumn y a winInARow y a winInADiagonal
        
        /*
         var rawDataOut = Array(1...40)
         var maskPixels = [Int](count: 10, repeatedValue: 0)
         
         for var i: Int = 0, j: Int = 0; i < rawDataOut.count-3; i += 4, ++j {
            maskPixels[j] = rawDataOut[i + 3]
            }
 */
    }
}
