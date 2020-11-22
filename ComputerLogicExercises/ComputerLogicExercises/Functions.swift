//
//  Functions.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Functions {
    
    func connec(formula: Formula) -> Int {
        if formula is Atom {
            return 0
        }
        else if formula is Not {
            guard let newFormula = formula as? Not else {
                return 0
            }
            return 1 + connec(formula: newFormula.atom)
        }
        else {
            guard let newFormula = formula as? Implies else {
                return 0
            }
            return 1 + connec(formula: newFormula.left) + connec(formula: newFormula.right)
        }
    }
    
    func atoms(formula: Formula) -> [String]{
        if formula is Atom {
            return [formula.getFormulaDescription()]
        }
        else if formula is Not {
            guard let newFormula = formula as? Not else {
                return []
            }
            return atoms(formula: newFormula.atom)
        }
        else {
            guard let newFormula = formula as? Implies else {
                return []
            }
            return atoms(formula: newFormula.left) + atoms(formula: newFormula.right)
        }
    }
}
