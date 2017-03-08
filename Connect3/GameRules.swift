//
//  GameRules.swift
//  Connect3
//
//  Created by Jose Sanchez Rodriguez on 8/3/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

//MARK: - Protocols
protocol GameRules {
    init(board: Board)
    func winner() -> Player
}

//MARK: - Rules
struct Connect3Rules: GameRules {
    let _board: Board
    let _MaxCoins = 3 // Número de fichas para ganar
    init(board: Board) {
        _board = board
    }
    
    //MARK: - Forma del curso de hacerlo
    // Función que retorna el jugador que ha ganado. Si nadie gana, retorna Empty
    func winner() -> Player {
        // Validación en columnas
        for player in [Player.Red, Player.White] {
            if winnerInColumns(player: player, board: _board) {
                return player
            }
        }
        
        // Validación en filas
        let transpoded = _board.transposed()
        
        for player in [Player.Red, Player.White] {
            if winnerInColumns(player: player, board: transpoded) {
                return player
            }
        }
        
        // Validación en diagonal hacia arriba
        
        // Validación en diagonal hacia abajo
        
        return .Empty
    }
    
    // Función que comprueba si el Player a ganado en una columna
    func winnerInColumns(player: Player, board: Board) -> Bool {
        for column in 0..<Board.width {
            if winner(player: player, column: column, board: board) {
                return true
            }
        }
        return false
    }
    
    func winner(player: Player, column: Int, board: Board) -> Bool {
        guard let col = board[column] else {
            return false
        }
        
        var total = 0
        
        // Helper functions
        // Función que comprueba si se ha llegado a 3
        func isAWin() -> Bool {
            if total >= _MaxCoins {
                return true
            } else {
                return false
            }
        }
        
        for currentPlayer in col {
            if currentPlayer == player {
                total += 1
                
                // Se comprueba que es una victoria
                if isAWin() {
                    break
                }
            } else {
                total = 0
            }
        }
        return isAWin()
    }
    
    
    //MARK: - Forma propia de hacerlo
    // Función que retorna si el jugador ha ganado en una columna partiendo de una fila
    func playerWinnerInAColumnFromRow (col: Int, row: Int, player: Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return false
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return false
        }
        
        var countPlayer = 0
        
        if row < Board.numberOfChipsToWin-1 {
            return false
        }
        
        for index in (0...row).reversed() {
            if _board.playerAt(col: col, row: index) == player {
                countPlayer += 1
                
                if countPlayer == Board.numberOfChipsToWin {
                    return true
                }
            } else {
                return false
            }
        }
        return false
    }
    
    // Función que retorna si el jugador ha ganado en una columna
    func playerWinnerInAColumn (col: Int, player:  Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return false
        }
        
        return playerWinnerInAColumnFromRow(col: col, row: Board.height-1, player: player)
    }
    
    // Función que retorna si un juagador ha ganado en una columna
    func winnerInAColumn (col: Int) -> Player {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return .Empty
        }
        
        if playerWinnerInAColumn(col: col, player: .Red) == true {
            return .Red
        } else if playerWinnerInAColumn(col: col, player: .White) == true {
            return .White
        } else {
            return .Empty
        }
    }
    
    // Función que retorna si el jugador ha ganado en una fila partiendo de una columna
    func playerWinnerInARowFromColumn (col: Int, row: Int, player: Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return false
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return false
        }
        
        var countPlayer = 0
        
        // Se valida hacia la izquierda
        var indexCol = col
        while indexCol >= 0 && _board.playerAt(col: indexCol, row: row) == player {
            countPlayer += 1
            
            if countPlayer == Board.numberOfChipsToWin {
                return true
            }
            
            indexCol = indexCol - 1
        }
        
        // Se valida hacia la derecha
        indexCol = col+1
        while indexCol < Board.width && _board.playerAt(col: indexCol, row: row) == player {
            countPlayer += 1
            
            if countPlayer == Board.numberOfChipsToWin {
                return true
            }
            
            indexCol = indexCol + 1
            
        }
        
        // Otra forma de hacerlo
        // Se valida hacia la izquierda
        /*
         for indexCol in (0...col).reversed() where playerAt(col: indexCol, row: row) == player {
         if playerAt(col: indexCol, row: row) == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         break
         }
         }
         
         // Se valida hacia la derecha
         for indexCol in col...Board.width {
         if playerAt(col: indexCol, row: row) == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         break
         }
         }
         */
        
        return false
    }
    
    // Función que transpone el board (filas -> columnas, columnas -> filas)
    
    
    // Función que retorna si el jugador ha ganado en una fila
    func playerWinnerInARow (row: Int, player:  Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return false
        }
        
        return playerWinnerInARowFromColumn(col: 0, row: row, player: player)
    }
    
    // Función que retorna si un juagador ha ganado en una fila
    func winnerInARow (row: Int) -> Player {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return .Empty
        }
        
        if playerWinnerInARow(row: row, player: .Red) == true {
            return .Red
        } else if playerWinnerInARow(row: row, player: .White) == true {
            return .White
        } else {
            return .Empty
        }
    }
    
    // Función que retorna si el jugador ha ganado en diagonal hacia la derecha
    func winInADiagonalLeft (col: Int, row: Int, player: Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return false
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return false
        }
        
        var countPlayer = 0
        
        // Se valida en diagonal hacia la izquierda y abajo
        var indexCol = col
        var indexRow = row
        while (indexCol >= 0 && indexRow >= 0) && _board.playerAt(col: indexCol, row: indexRow) == player {
            countPlayer += 1
            
            if countPlayer == Board.numberOfChipsToWin {
                return true
            }
            
            indexCol = indexCol - 1
            indexRow = indexRow - 1
        }
        
        // Se valida en diagonal hacia la derecha y arriba
        indexCol = col + 1
        indexRow = row + 1
        while (indexCol < Board.width && indexRow < Board.height) && _board.playerAt(col: indexCol, row: indexRow) == player {
            countPlayer += 1
            
            if countPlayer == Board.numberOfChipsToWin {
                return true
            }
            
            indexCol = indexCol + 1
            indexRow = indexRow + 1
        }
        
        // Otra forma de hacerlo
        // Se valida en diagonal hacia la izquierda y abajo
        /*
         for var indexCol: Int = col, indexRow: Int = row; indexCol >= 0, indexRow >= 0; --indexCol, --indexRow {
         if playerAt(col: index, row: row) == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         break
         }
         }
         
         // Se valida en diagonal hacia la derecha y arriba
         for var indexCol: Int = col, indexRow: Int = row; indexCol < Board.width, indexRow < Board.height; ++indexCol, ++indexRow {
         if playerAt(col: index, row: row) == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         break
         }
         }
         */
        
        return false
    }
    
    // Función que retorna si el jugador ha ganado en diagonal hacia la izquierda
    func winInADiagonalRight (col: Int, row: Int, player: Player) -> Bool {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return false
        }
        
        // Se controla que la fila se encuentre entre los límites permitidos
        guard row >= 0 && row < Board.height else {
            return false
        }
        
        var countPlayer = 0
        
        // Se valida en diagonal hacia la izquierda y arriba
        var indexCol = col
        var indexRow = row
        while (indexCol >= 0 && indexRow < Board.height) && _board.playerAt(col: indexCol, row: indexRow) == player {
            countPlayer += 1
            
            if countPlayer == Board.numberOfChipsToWin {
                return true
            }
            
            indexCol = indexCol - 1
            indexRow = indexRow + 1
        }
        
        // Se valida en diagonal hacia la derecha y abajo
        indexCol = col + 1
        indexRow = row - 1
        while (indexCol < Board.width && indexRow >= 0) && _board.playerAt(col: indexCol, row: indexRow) == player {
            countPlayer += 1
            
            if countPlayer == Board.numberOfChipsToWin {
                return true
            }
            
            indexCol = indexCol + 1
            indexRow = indexRow - 1
        }
        
        // Otra forma de hacerlo
        // Se valida en diagonal hacia la izquierda y arriba
        /*
         for var indexCol: Int = col, indexRow: Int = row; indexCol >= 0, indexRow < Board.height; --indexCol, ++indexRow {
         if playerAt(col: index, row: row) == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         break
         }
         }
         
         // Se valida en diagonal hacia la derecha y abajo
         for var indexCol: Int = col, indexRow: Int = row; indexCol < Board.width, indexRow >= 0; ++indexCol, --indexRow {
         if playerAt(col: index, row: row) == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         break
         }
         }
         */
        
        return false
    }
    
    // Función que retorna si un jugador ha ganado en la columna
    // Si nadie ha ganado retorna Empty
    func winColumn (col: Int) -> Player {
        
        /*
         guard col >= 0 && col < Board.width else {
         return .Empty
         }
         
         var countPlayer = 0
         var currentPlayer = playerAt(col: col, row: 0)
         let AntPlayer = .Empty
         
         for index in 0...Board.height {
         if currentPlayer == player {
         countPlayer += 1
         
         if countPlayer == Board.numberOfChipsToWin {
         return true
         }
         } else {
         return false
         }
         }
         return false
         */
        return .Empty
    }
    
    // Función que retorna si el jugador ha ganado en una columna
    func tie () -> Bool {
        
        // Llamar en bucle a playerWinnerInAColumnFromRow y a playerWinnerInARowFromColumn y a winInADiagonal
        
        /*
         var rawDataOut = Array(1...40)
         var maskPixels = [Int](count: 10, repeatedValue: 0)
         
         for var i: Int = 0, j: Int = 0; i < rawDataOut.count-3; i += 4, ++j {
         maskPixels[j] = rawDataOut[i + 3]
         }
         
         
         for (col in )
         
         playerWinnerInAColumnFromRow (col: Int, row: Int, player: Player) -> Bool {
         
         
         for var indexCol: Int = col, indexRow: Int = row; indexCol < Board.width, indexRow >= 0; ++indexCol, --indexRow {		
         
         
         
         for row in 0..<8 {
         if row % 2 == 0 {
         continue
         }
         
         for column in 0..<8 {
         sum += row * column
         }
         }
         
         }
         */
        return false
    }
    
}
