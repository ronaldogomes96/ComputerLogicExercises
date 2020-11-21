//
//  main.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

let formula1 = Atom(atom: "p")
let formula2 = Atom(atom: "q")
let formula3 = And(left: formula1, right: formula2)
let formula4 = And(left: Atom(atom: "p"), right: Atom(atom: "s"))
let formula5 = Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s")))
let formula6 = Or(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: Atom(atom: "q"))
let formula7 = Implies(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: And(left: Atom(atom: "q"), right: Atom(atom: "r")))
let formula8 = Implies(left: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s"))), right: And(left: Atom(atom: "q"), right: Not(atom: And(left: Atom(atom: "p"), right: Atom(atom: "s")))))

print(formula1.getFormulaDescription())
print(formula2.getFormulaDescription())
print(formula3.getFormulaDescription())
print(formula4.getFormulaDescription())
print(formula5.getFormulaDescription())
print(formula6.getFormulaDescription())
print(formula7.getFormulaDescription())
print(formula8.getFormulaDescription())

