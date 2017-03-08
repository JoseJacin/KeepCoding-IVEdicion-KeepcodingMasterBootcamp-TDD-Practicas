//
//  Board.swift
//  Connect3
//
//  Created by Jose Sanchez Rodriguez on 6/3/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

// (red, red, white, empty)

// Columna con los jugadores empezando desde abajo
struct Board {
    
    //MARK: - Typealias
    typealias BoardColumn = [Player]
    
    //MARK: - Properties
    static let width = 5 // Ancho
    static let height = 5 // Alto
    static let numberOfChipsToWin = 3 // Número de fichas para ganar
    
    var _boardRepresentation : [BoardColumn]


    //MARK: - Initialization
    init() {
        // Create the 5x5 board
        _boardRepresentation =
        [
            [.Empty, .Empty, .Empty, .Empty, .Empty],
            [.Empty, .Empty, .Empty, .Empty, .Empty],
            [.Empty, .Empty, .Empty, .Empty, .Empty],
            [.Empty, .Empty, .Empty, .Empty, .Empty],
            [.Empty, .Empty, .Empty, .Empty, .Empty]
        ]
    }
    
    // CustomStringConvertible
    var description: String {
        return _boardRepresentation.description
    }
    
    // Función que establece un jugador en la primera posición libre
    // Si no hay posiciones libres, no hace nada
    mutating func playAt(col: Int, player: Player) {
        // Se controla que la columna se encuentre entre los límites permitidos
        guard col >= 0 && col < Board.width else {
            return
        }
        
        let column = _boardRepresentation[col]
        
        // Se asigna el jugador en la primera posición libre (Empty)
        for (index, currentPlayer) in column.enumerated() {
            if currentPlayer == .Empty {
                // Se mete la ficha
                _boardRepresentation[col][index] = player
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
        return _boardRepresentation[col][row]
    }
}

//MARK: - Extensions
// Proxies
extension Board {
    var proxyForEquality : [Player] {
        get {
            return _boardRepresentation.flatMap{$0}
        }
    }
    
    var proxyForHashValue : Int {
        get {
            var proxy = [Int]()
            var newVal = 0
            for player in proxyForEquality {
                if player == .Red {
                    newVal = 0
                }
                if player == .White {
                    newVal = 1
                }
                if player == .Empty {
                    newVal = 2
                }
                proxy.append(newVal)
            }
            return proxy.reduce(0, { (a, b) -> Int in
                a+b
            })
        }
    }
}

extension Board : Equatable {
    public static func ==(lhs: Board, rhs: Board) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Board : Hashable {
    public var hashValue: Int {
        get {
            return self.proxyForHashValue
        }
    }
}

//MARK: - Accessors
extension Board {
    // subscript es una función que no tiene noombre que que se accede a ella mediante los corchetes []
    // Función que retorna un BoardColumn Optional en caso en que esté fuera de rango
    subscript (column: Int) -> BoardColumn? {
        guard column >= 0 && column < Board.width else {
            return nil
        }
        return _boardRepresentation[column]
    }
}

//MARK: - Transformations
extension Board {
    
    init(boardRepresentation: [BoardColumn]) {
        _boardRepresentation = boardRepresentation
    }
    
    func transposed() -> Board {
        var aux = Player.Empty
        var transposedRepresentation = _boardRepresentation
        
        for i in 0..<Board.width {
            for j in 0..<Board.height {
                aux = transposedRepresentation[i][j]
                transposedRepresentation[i][j] = transposedRepresentation[j][i]
                transposedRepresentation[j][i] = aux
            }
        }
        return Board(boardRepresentation: transposedRepresentation)
    }
}
