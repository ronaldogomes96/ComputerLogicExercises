//
//  Not.swift
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


class Not: Formula {
    
    let inner: Formula
    
    init(_ atom: Formula) {
        self.inner = atom
    }
    
    func getFormulaDescription() -> String {
        return "-\(inner.getFormulaDescription())"
    }
    
}
