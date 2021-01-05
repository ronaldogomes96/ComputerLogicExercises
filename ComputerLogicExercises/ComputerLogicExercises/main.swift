//
//  main.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

let functions = Functions()

let formula1 = Atom(atom: "p")
let formula2 = Atom(atom: "q")
let formula0 = Not(atom: formula2)
let formula3 = Or(left: formula1, right: formula2)
let formula4 = And(left: Atom(atom: "p"), right: Atom(atom: "s"))
let formula5 = Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s")))
let formula6 = Or(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: Atom(atom: "q"))
let formula7 = Implies(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: And(left: Atom(atom: "q"), right: Atom(atom: "r")))
let formula8 = Implies(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: And(left: Atom(atom: "q"), right: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s")))))
let formula9 = Atom(atom: "r")
let formula11 = Atom(atom: "t")
let formula10 = Implies(left: formula3, right: formula9)
let formula12 = Or(left: formula9, right: formula11)
let formula13 = Implies(left: formula1, right: formula0)
let formula14 = Not(atom: Implies(left: formula3, right: formula1))
let formula15 = Or(left: Or(left: And(left: formula1, right: formula2), right: Not(atom: formula1)), right: formula0)
let formula16 = Implies(left: formula1, right: formula0)
let formula17 = Not(atom: Implies(left: formula1, right: formula3))
let formula18 = And(left: And(left: Implies(left: formula1, right: formula2), right: Or(left: formula9, right: Not(atom: formula2))),
                    right: And(left: Or(left: formula11, right: Not(atom: formula9)), right: formula1))


print("Formulas logicas")
print(formula0.getFormulaDescription())
print(formula1.getFormulaDescription())
print(formula2.getFormulaDescription())
print(formula3.getFormulaDescription())
print(formula4.getFormulaDescription())
print(formula5.getFormulaDescription())
print(formula6.getFormulaDescription())
print(formula7.getFormulaDescription())
print(formula8.getFormulaDescription())
print(formula9.getFormulaDescription())
print(formula10.getFormulaDescription())
print(formula11.getFormulaDescription())
print(formula12.getFormulaDescription())
print(formula13.getFormulaDescription())
print(formula14.getFormulaDescription())
print(formula15.getFormulaDescription())
print(formula16.getFormulaDescription())
print(formula17.getFormulaDescription())
print(formula18.getFormulaDescription())


print("Quantidade de atomos de cada formula")
print("\(formula0.getFormulaDescription()): \(functions.numberOfAtoms(formula: formula0))")
print("\(formula1.getFormulaDescription()): \(functions.numberOfAtoms(formula: formula1))")
print("\(formula3.getFormulaDescription()): \(functions.numberOfAtoms(formula: formula3))")
print("\(formula8.getFormulaDescription()): \(functions.numberOfAtoms(formula: formula8))")

print("Quantidade de connectivos de cada formula")
print("\(formula0.getFormulaDescription()): \(functions.connec(formula: formula0))")
print("\(formula1.getFormulaDescription()): \(functions.connec(formula: formula1))")
print("\(formula3.getFormulaDescription()): \(functions.connec(formula: formula3))")
print("\(formula5.getFormulaDescription()): \(functions.connec(formula: formula5))")
print("\(formula7.getFormulaDescription()): \(functions.connec(formula: formula7))")
print("\(formula8.getFormulaDescription()): \(functions.connec(formula: formula8))")

print("Atomos de cada formula")
print("\(formula1.getFormulaDescription()): \(functions.atoms(formula: formula1))")
print("\(formula3.getFormulaDescription()): \(functions.atoms(formula: formula3))")
print("\(formula8.getFormulaDescription()): \(functions.atoms(formula: formula8))")

print("Substituicao")
print("\(functions.substitution(formula: formula10, oldSubformula: formula0, newSubformula: formula12).getFormulaDescription())")

print("Valor verdade de cada formula")
print("\(formula0.getFormulaDescription()): \(functions.truthValue(formula: formula0, interpretation: ["q": true]))")
print("\(formula0.getFormulaDescription()): \(functions.truthValue(formula: formula0, interpretation: ["q": false]))")
print("\(formula1.getFormulaDescription()): \(functions.truthValue(formula: formula1, interpretation: ["p": false]))")
print("\(formula12.getFormulaDescription()): \(functions.truthValue(formula: formula12, interpretation: ["r": false, "t": true]))")
print("\(formula12.getFormulaDescription()): \(functions.truthValue(formula: formula12, interpretation: ["r": false, "t": false]))")
print("\(formula3.getFormulaDescription()): \(functions.truthValue(formula: formula3, interpretation: ["p": true, "q": false]))")
print("\(formula3.getFormulaDescription()): \(functions.truthValue(formula: formula3, interpretation: ["p": true, "q": true]))")
print("\(formula8.getFormulaDescription()): \(functions.truthValue(formula: formula8, interpretation: ["p": false, "s": false, "q": true]))")
print("\(formula8.getFormulaDescription()): \(functions.truthValue(formula: formula8, interpretation: ["p": false, "s": false, "q": false]))")
print("\(formula8.getFormulaDescription()): \(functions.truthValue(formula: formula8, interpretation: ["p": true, "s": true, "q": false]))")
print("\(formula8.getFormulaDescription()): \(functions.truthValue(formula: formula8, interpretation: ["p": true, "s": true, "q": false]))")

print("Satisfabilidade de cada formula")
print("\(formula3.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula3))")
print("\(formula13.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula13))")
print("\(formula10.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula10))")
print("\(formula8.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula8))")
print("\(formula15.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula15))")
print("\(formula14.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula14))")
print("\(formula17.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula17))")
print("\(formula18.getFormulaDescription()): \(functions.satisfabilityChecking(formula: formula18))")



print("Validade de cada formula")
print("\(formula3.getFormulaDescription()): \(functions.validityChecking(formula: formula3))")
print("\(formula13.getFormulaDescription()): \(functions.validityChecking(formula: formula13))")
print("\(formula7.getFormulaDescription()): \(functions.validityChecking(formula: formula7))")
print("\(formula10.getFormulaDescription()): \(functions.validityChecking(formula: formula10))")
print("\(formula8.getFormulaDescription()): \(functions.validityChecking(formula: formula8))")
print("\(formula15.getFormulaDescription()): \(functions.validityChecking(formula: formula15))")
print("\(formula14.getFormulaDescription()): \(functions.validityChecking(formula: formula14))")
print("\(formula17.getFormulaDescription()): \(functions.validityChecking(formula: formula17))")


print("Consequencia logica")
print("\(formula3.getFormulaDescription()), \(formula5.getFormulaDescription()) |= \(formula0.getFormulaDescription()) : \(functions.logicalConsequence(premise: [formula3, formula5], conclusion: formula0))")
print("\(formula0.getFormulaDescription()), \(formula10.getFormulaDescription()) |= \(formula8.getFormulaDescription()) : \(functions.logicalConsequence(premise: [formula0, formula10], conclusion: formula8))")
print("\(formula1.getFormulaDescription()) |= \(formula2.getFormulaDescription()) : \(functions.logicalConsequence(premise: [formula0, formula1], conclusion: formula2))")
