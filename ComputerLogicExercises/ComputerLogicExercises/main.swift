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
let formula3 = And(left: formula1, right: formula0) /////////////////
let formula4 = And(left: Atom(atom: "p"), right: Atom(atom: "s"))
let formula5 = Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s")))
let formula6 = Or(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: Atom(atom: "q"))
let formula7 = Implies(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: And(left: Atom(atom: "q"), right: Atom(atom: "r")))
let formula8 = Implies(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: And(left: Atom(atom: "q"), right: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s")))))
let formula9 = Atom(atom: "r")
let formula11 = Atom(atom: "t")
let formula10 = Implies(left: formula3, right: formula9)
let formula12 = Or(left: formula9, right: formula11)


print("Formulas logicas")
print(formula10.getFormulaDescription())
print(formula1.getFormulaDescription())
print(formula2.getFormulaDescription())
print(formula3.getFormulaDescription())
print(formula4.getFormulaDescription())
print(formula5.getFormulaDescription())
print(formula6.getFormulaDescription())
print(formula7.getFormulaDescription())
print(formula8.getFormulaDescription())

print("Quantidade de connectivos de cada formula")
print("\(formula0.getFormulaDescription()): \(functions.connec(formula: formula0))")
print("\(formula1.getFormulaDescription()): \(functions.connec(formula: formula1))")
print("\(formula3.getFormulaDescription()): \(functions.connec(formula: formula3))")
print("\(formula5.getFormulaDescription()): \(functions.connec(formula: formula4))") // Printa 1 quando é pra ser 2, porque?
print("\(formula7.getFormulaDescription()): \(functions.connec(formula: formula7))")
print("\(formula8.getFormulaDescription()): \(functions.connec(formula: formula8))")

print("Quantidade de atoms de cada formula")
print("\(formula1.getFormulaDescription()): \(functions.atoms(formula: formula1))")
print("\(formula3.getFormulaDescription()): \(functions.atoms(formula: formula3))")
print("\(formula8.getFormulaDescription()): \(functions.atoms(formula: formula8))")

print("Substituicao")
print("\(functions.substitution(formula: formula10, oldSubformula: formula0, newSubformula: formula12).getFormulaDescription())")

