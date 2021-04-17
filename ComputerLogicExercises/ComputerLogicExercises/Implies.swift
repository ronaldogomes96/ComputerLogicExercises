//
//  Implies.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Implies: Formula {
    
    let left: Formula
    let right: Formula
    
    init(_ left: Formula, _ right: Formula) {
        self.left = left
        self.right = right
    }
    
    func getFormulaDescription() -> String {
        return "(\(left.getFormulaDescription()) -> \(right.getFormulaDescription()))"
    }
}
