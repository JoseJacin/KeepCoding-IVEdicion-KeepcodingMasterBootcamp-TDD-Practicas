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
    static let numberOfChipsToWin = 3 // Número de fichas para ganar
    
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
    
    // Función que retorna el jugador que se encuentra en esa posición
    // Si no hay jugador, retorna Empty
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
        
        if row < numberOfChipsToWin-1 {
            return false
        }
        
        for index in (0...row).reversed() {
            if playerAt(col: col, row: index) == player {
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
		var indexCol = col
		while indexCol >= 0 && playerAt(col: indexCol, row: row) == player {
			countPlayer += 1
			
			if countPlayer == numberOfChipsToWin {
                    return true
            }
			
			indexCol -=1
		}
		
		// Se valida hacia la derecha
		indexCol = col+1
		while indexCol < Board.width && playerAt(col: indexCol, row: row) == player {
			countPlayer += 1
			
			if countPlayer == numberOfChipsToWin {
                    return true
            }
			
			indexCol +=1
		}
		
		// Otra forma de hacerlo
		// Se valida hacia la izquierda
		/*
		for indexCol in (0...col).reversed() where playerAt(col: indexCol, row: row) == player {
            if playerAt(col: indexCol, row: row) == player {
                countPlayer += 1
                
                if countPlayer == numberOfChipsToWin {
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
                
                if countPlayer == numberOfChipsToWin {
                    return true
                }
            } else {
                break
            }
        }
		*/
        
        return false
    }
    
    // Función que retorna si el jugador ha ganado en diagonal hacia la derecha
    func winInADiagonalLeft (col: Int, row: Int, player: Player) -> Bool {
		// Se controla que la columna se encuentre entre los límites permitidos
		guard col >= 0 && col < Board.width else {
			return .Empty
		}

		// Se controla que la fila se encuentre entre los límites permitidos
		guard row >= 0 && row < Board.height else {
			return .Empty
		}

		var countPlayer = 0
		
		// Se valida en diagonal hacia la izquierda y abajo
		var indexCol = col
		var indexRow = row
		while (indexCol >= 0 && indexRow >= 0) && playerAt(col: indexCol, row: indexRow) == player {
			countPlayer += 1
			
			if countPlayer == numberOfChipsToWin {
                    return true
            }
			
			indexCol -=1
			indexRow -=1
		}
		
		// Se valida en diagonal hacia la derecha y arriba
		var indexCol = col+1
		var indexRow = row+1
		while (indexCol < Board.width && indexRow < Board.height) && playerAt(col: indexCol, row: indexRow) == player {
			countPlayer += 1
			
			if countPlayer == numberOfChipsToWin {
                    return true
            }
			
			indexCol +=1
			indexRow +=1
		}
		
		// Otra forma de hacerlo
		// Se valida en diagonal hacia la izquierda y abajo
		/*
		for var indexCol: Int = col, indexRow: Int = row; indexCol >= 0, indexRow >= 0; --indexCol, --indexRow {
			if playerAt(col: index, row: row) == player {
				countPlayer += 1
				
				if countPlayer == numberOfChipsToWin {
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
				
				if countPlayer == numberOfChipsToWin {
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
			return .Empty
		}

		// Se controla que la fila se encuentre entre los límites permitidos
		guard row >= 0 && row < Board.height else {
			return .Empty
		}

		var countPlayer = 0
		
		// Se valida en diagonal hacia la izquierda y arriba
		var indexCol = col
		var indexRow = row
		while (indexCol >= 0 && indexRow < Board.height) && playerAt(col: indexCol, row: indexRow) == player {
			countPlayer += 1
			
			if countPlayer == numberOfChipsToWin {
                    return true
            }
			
			indexCol -=1
			indexRow +=1
		}
		
		// Se valida en diagonal hacia la derecha y abajo
		var indexCol = col+1
		var indexRow = row-1
		while (indexCol < Board.width && indexRow >= 0) && playerAt(col: indexCol, row: indexRow) == player {
			countPlayer += 1
			
			if countPlayer == numberOfChipsToWin {
                    return true
            }
			
			indexCol +=1
			indexRow -=1
		}
		
		// Otra forma de hacerlo
		// Se valida en diagonal hacia la izquierda y arriba
		/*
		for var indexCol: Int = col, indexRow: Int = row; indexCol >= 0, indexRow < Board.height; --indexCol, ++indexRow {
			if playerAt(col: index, row: row) == player {
				countPlayer += 1
				
				if countPlayer == numberOfChipsToWin {
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
				
				if countPlayer == numberOfChipsToWin {
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
		guard col >= 0 && col < Board.width else {
            return .Empty
        }
        
        var countPlayer = 0
        var currentPlayer = playerAt(col: col, row: index)
		var AntPlayer = .Empty
        
        for index in 0...Board.height {
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
    func tie () -> Bool {
        // Llamar en bucle a winInAColumn y a winInARow y a winInADiagonal
        
        /*
         var rawDataOut = Array(1...40)
         var maskPixels = [Int](count: 10, repeatedValue: 0)
         
         for var i: Int = 0, j: Int = 0; i < rawDataOut.count-3; i += 4, ++j {
            maskPixels[j] = rawDataOut[i + 3]
            }

 
		for (col in )
		
		winInAColumn (col: Int, row: Int, player: Player) -> Bool {
		

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
}

