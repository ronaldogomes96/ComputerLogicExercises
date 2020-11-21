//
//  And.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class And: Implies {
    
    override func getFormulaDescription() -> String {
        return "(\(left.getFormulaDescription()) ˆ \(right.getFormulaDescription()))"
    }
}
