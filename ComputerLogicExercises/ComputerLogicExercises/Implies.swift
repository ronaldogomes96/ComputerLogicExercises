//
//  Implies.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

/*
 This module is designed to define formulas in propositional logic.
 
 For example, the following piece of code creates an object representing (p v s).
 formula1 = Or(Atom('p'), Atom('s'))

 As another example, the piece of code below creates an object that represents (p → (p v s)).
 formula2 = Implies(Atom('p'), Or(Atom('p'), Atom('s')))
 */


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
