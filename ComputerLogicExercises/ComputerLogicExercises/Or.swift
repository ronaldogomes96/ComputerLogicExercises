//
//  oR.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Or: Formula {
    
    let left: Formula
    let right: Formula
    
    init(left: Formula, right: Formula) {
        self.left = left
        self.right = right
    }
    
    func getFormulaDescription() -> String {
        return "(\(left.getFormulaDescription()) v \(right.getFormulaDescription()))"
    }
}
