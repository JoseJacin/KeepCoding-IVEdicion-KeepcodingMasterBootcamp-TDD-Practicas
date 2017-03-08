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
    init(board: Board) {
        _board = board
    }
    
    //Función que retorna el jugador que ha ganado. Si nadie gana, retorna Empty
    func winner() -> Player {
        return .Red
    }
}
