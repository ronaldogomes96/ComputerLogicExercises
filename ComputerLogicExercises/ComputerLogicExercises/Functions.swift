//
//  Functions.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Functions {
    
    /*
     Returns the number of atoms occurring in a formula.
         For instance,
         number_of_atoms(Implies(Atom('q'), And(Atom('p'), Atom('q'))))
         must return 3 (Observe that this function counts the repetitions of atoms)
     */
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
            return 1 + connec(formula: newFormula.inner)
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
    
    /*
     Returns the set of all subformulas of a formula.
         For example, observe the piece of code below.
         my_formula = Implies(Atom('p'), Or(Atom('p'), Atom('s')))
         for subformula in subformulas(my_formula):
             print(subformula)
         This piece of code prints p, s, (p v s), (p → (p v s))
         (Note that there is no repetition of p)
     */
    func listOfAtoms(formula: Formula) -> [String]{
        let listOfAtoms = self.atoms(formula: formula)
        let setList = Set(listOfAtoms)
        let listOfAtomsTransformed = setList.map { String($0) }
        return listOfAtomsTransformed
    }
    
    /*
     """Returns the set of all atoms occurring in a formula.
         For example, observe the piece of code below.
         my_formula = Implies(Atom('p'), Or(Atom('p'), Atom('s')))
         for atom in atoms(my_formula):
             print(atom)
         This piece of code above prints: p, s
         (Note that there is no repetition of p)
         """
     */
    private func atoms(formula: Formula) -> [String]{
        if formula is Atom {
            return [formula.getFormulaDescription()]
        }
        else if formula is Not {
            guard let newFormula = formula as? Not else {
                return []
            }
            return atoms(formula: newFormula.inner)
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
    
    /*
     Returns a new formula obtained by replacing all occurrences
         of old_subformula in the input formula by new_subformula.
     */
    func substitution(formula: Formula, oldSubformula: Formula, newSubformula:  Formula) -> Formula {
        if formula is Atom && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            return formula
        }
        else if formula.getFormulaDescription() == oldSubformula.getFormulaDescription() {
            return newSubformula
        }
        else if formula is Implies && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            if let newFormula = formula as? Implies {
                return Implies(substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                               substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
        }
        else if formula is And && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            if let newFormula = formula as? And {
                return And(substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                           substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
        }
        else if formula is Or && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
            if let newFormula = formula as? Or {
                return Or(substitution(formula: newFormula.left, oldSubformula: oldSubformula, newSubformula: newSubformula),
                          substitution(formula: newFormula.right, oldSubformula: oldSubformula, newSubformula: newSubformula))
            }
        }
        else {
            if formula is Not && formula.getFormulaDescription() != oldSubformula.getFormulaDescription() {
                if let newFormula = formula as? Not {
                    return Not(newFormula.inner)
                }
            }
        }
        return formula
    }
    
    /*
     Determines the truth value of a formula in an interpretation (valuation).
         An interpretation may be defined as dictionary. For example, {'p': True, 'q': False}.
     */
    func truthValue(formula: Formula, interpretation: [String: Bool]) -> Bool {
        if formula is Atom {
            return interpretation[formula.getFormulaDescription()] ?? Bool.init()
        }
        else if formula is Not {
            guard let newFormula = formula as? Not else {
                return Bool.init()
            }
            return !truthValue(formula: newFormula.inner, interpretation: interpretation)
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
    
    /*
     Checks whether formula is satisfiable.
         In other words, if the input formula is satisfiable, it returns an interpretation that assigns true to the formula.
         Otherwise, it returns False.
     */
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
    
    /*
     Returns True if formula is a logically valid (tautology). Otherwise, it returns False
     */
    func validityChecking(formula: Formula) -> Bool {
        if (satisfabilityChecking(formula: Not(formula)) as? Bool) == false {
            return true
        } else {
            return false
        }
    }
    
    /*
     Returns True if the conclusion is a logical consequence of the set of premises. Otherwise, it returns False.
     */
    func logicalConsequence(premise: [Formula], conclusion: Formula) -> Bool {
        var premise = premise
        var uniquePremise: Formula = premise.popLast()!
        premise.forEach { formula in
            uniquePremise = And(uniquePremise, formula)
        }
        let consequence = And(uniquePremise, Not(conclusion))
        if satisfabilityChecking(formula: consequence) is Bool {
            return true
        } else {
            return false
        }
    }
}
