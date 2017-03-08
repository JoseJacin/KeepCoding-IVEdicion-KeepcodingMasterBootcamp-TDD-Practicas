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
    func winnerInColumns(player: Player) -> Bool {
        for column in 0..<Board.width {
            if winner(player: player, column: column) {
                return true
            }
        }
        return false
    }
    
    
    //Función que retorna el jugador que ha ganado. Si nadie gana, retorna Empty
    func winner() -> Player {
        // Valicación en columnas
        for player in [Player.Red, Player.White] {
            if winnerInColumns(player: player) {
                return player
            }
        }
        
        // Valicación en filas
        
        // Valicación en diagonal
        
        return .Empty
    }
    
    func winner(player: Player, column: Int) -> Bool {
        guard let col = _board[column] else {
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
    
}
