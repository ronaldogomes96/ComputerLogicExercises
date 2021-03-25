//
//  Functions.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Functions {
    
    func numberOfAtoms(formula: Formula) -> Int {
        return listOfAtoms(formula: formula).count
    }
    
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
        else if formula is Implies{
            guard let newFormula = formula as? Implies else {
                return 0
            }
            return 1 + connec(formula: newFormula.left) + connec(formula: newFormula.right)
        }
        else if formula is And{
            guard let newFormula = formula as? And else {
                return 0
            }
            return 1 + connec(formula: newFormula.left) + connec(formula: newFormula.right)
        }
        else {
            guard let newFormula = formula as? Or else {
                return 0
            }
            return 1 + connec(formula: newFormula.left) + connec(formula: newFormula.right)
        }
    }
    
    func listOfAtoms(formula: Formula) -> [String]{
        let listOfAtoms = self.atoms(formula: formula)
        let setList = Set(listOfAtoms)
        let listOfAtomsTransformed = setList.map { String($0) }
        return listOfAtomsTransformed
    }
    
    private func atoms(formula: Formula) -> [String]{
        if formula is Atom {
            return [formula.getFormulaDescription()]
        }
        else if formula is Not {
            guard let newFormula = formula as? Not else {
                return []
            }
            return atoms(formula: newFormula.atom)
        }
        else if formula is Implies {
            guard let newFormula = formula as? Implies else {
                return []
            }
            return atoms(formula: newFormula.left) + atoms(formula: newFormula.right)
        }
        else if formula is And {
            guard let newFormula = formula as? And else {
                return []
            }
            return atoms(formula: newFormula.left) + atoms(formula: newFormula.right)
        }
        else {
            guard let newFormula = formula as? Or else {
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
            if let newFormula = formula as? Implies {
                return Implies(left: substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                               right: substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
        }
        else if formula is And && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            if let newFormula = formula as? And {
                return And(left: substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                           right: substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
        }
        else if formula is Or && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            if let newFormula = formula as? Or {
                return Or(left: substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                          right: substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
        }
        else {
            if formula is Not && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
                if let newFormula = formula as? Not {
                    return Not(atom: newFormula.atom)
                }
            }
        }
        return formula
    }
    
    func truthValue(formula: Formula, interpretation: [String: Bool]) -> Bool {
        if formula is Atom {
            return interpretation[formula.getFormulaDescription()] ?? Bool.init()
        }
        else if formula is Not {
            guard let newFormula = formula as? Not else {
                return Bool.init()
            }
            return !truthValue(formula: newFormula.atom, interpretation: interpretation)
        }
        else if formula is Implies {
            if let newFormula = formula as? Implies {
                if truthValue(formula: newFormula.left, interpretation: interpretation) == true &&
                    truthValue(formula: newFormula.right, interpretation: interpretation) == false {
                    return false
                }
                else if truthValue(formula: newFormula.left, interpretation: interpretation) == false ||
                            truthValue(formula: newFormula.right, interpretation: interpretation) == true {
                    return true
                }
            }
        }
        else if formula is And {
            if let newFormula = formula as? And {
                return truthValue(formula: newFormula.left, interpretation: interpretation) &&
                    truthValue(formula: newFormula.right, interpretation: interpretation)
            }
        }
        else if formula is Or {
            if let newFormula = formula as? Or {
                return truthValue(formula: newFormula.left, interpretation: interpretation) ||
                    truthValue(formula: newFormula.right, interpretation: interpretation)
            }
        }
        return Bool.init()
    }
    
    func satisfabilityChecking(formula: Formula) -> Any {
        let listOfAtoms = self.listOfAtoms(formula: formula)
        let setList = Set(listOfAtoms)
        var listOfAtomsTransformed = setList.map { String($0) }
        
        let interpretation = self.createInterpretations(formula: formula)
        
        listOfAtomsTransformed.forEach {
            if interpretation[$0] != nil {
                if let index = listOfAtomsTransformed.firstIndex(of: $0) {
                    listOfAtomsTransformed.remove(at: index)
                }
            }
        }
        
        return isSatisfactory(formula: formula, atoms: listOfAtomsTransformed, interpretation: interpretation)
    }
    
    private func isSatisfactory(formula: Formula, atoms: [String], interpretation: [String: Bool]) -> Any {
        if atoms == [] {
            if truthValue(formula: formula, interpretation: interpretation) {
                return interpretation
            } else {
                return false
            }
        }

        var newAtons = atoms
        let atom = newAtons.popLast() ?? ""
        var interpretationOne = interpretation
        var interpretationTwo = interpretation
        interpretationOne[atom] = true
        interpretationTwo[atom] = false

        let result = isSatisfactory(formula: formula, atoms: newAtons, interpretation: interpretationOne)
        if (result as? Bool) != false {
            return result
        }

        return isSatisfactory(formula: formula, atoms: newAtons, interpretation: interpretationTwo)
    }
    
    func createInterpretations(formula: Formula) -> [String: Bool] {
        var listOfFormulas = [formula]
        var interpretationFormulas = [String: Bool]()
        
        while true {
            let listOfFormulasActual = listOfFormulas
            for (index, insideFormula) in listOfFormulas.enumerated() {
                if let insideFormula = insideFormula as? And {
                    listOfFormulas.remove(at: index)
                    listOfFormulas.append(insideFormula.left)
                    listOfFormulas.append(insideFormula.right)
                }
            }
            if listOfFormulasActual.count == listOfFormulas.count {
                break
            }
        }
        
        listOfFormulas.forEach {
            if $0 is Atom {
                interpretationFormulas["\($0.getFormulaDescription())"] = true
            }
            if $0 is Not {
                interpretationFormulas["\($0.getFormulaDescription())"] = false
            }
        }
        
        return interpretationFormulas
    }
    
    func validityChecking(formula: Formula) -> Bool {
        if (satisfabilityChecking(formula: Not(atom: formula)) as? Bool) == false {
            return true
        } else {
            return false
        }
    }
    
    func logicalConsequence(premise: [Formula], conclusion: Formula) -> Bool {
        var uniquePremise: Formula = premise.first!
        premise.forEach { formula in
            uniquePremise = And(left: uniquePremise, right: formula)
        }
        let consequence = And(left: uniquePremise, right: Not(atom: conclusion))
        if (satisfabilityChecking(formula: consequence) as? Bool) == false{
            return true
        } else {
            return false
        }
    }
}
