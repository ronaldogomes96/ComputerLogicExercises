//
//  oR.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Or: Implies {
    
    override func getFormulaDescription() -> String {
        return "(\(left.getFormulaDescription()) v \(right.getFormulaDescription()))"
    }
}
