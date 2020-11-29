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
    
    func substitution(formula: Formula, oldSubformula: Formula, newSubformula:  Formula) -> Formula {
        if formula is Atom && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            return formula
        }
        else if formula.getFormulaDescription() == oldSubformula.getFormulaDescription() {
            return newSubformula
        }
        else if formula is Implies && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            if let newFormula = formula as? And {
                return And(left: substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                           right: substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
            else if let newFormula = formula as? Or {
                return Or(left: substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                          right: substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
            else {
                if let newFormula = formula as? Implies {
                    return Implies(left: substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                                   right: substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
                }
            }
        }
        else {
            if formula is Not && formula.getFormulaDescription() != formula.getFormulaDescription() {
                if let newFormula = formula as? Not {
                    return Not(atom: newFormula.atom)
                }
            }
        }
        return formula
    }
}
