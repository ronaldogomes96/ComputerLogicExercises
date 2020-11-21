//
//  Atom.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Atom: Formula {
    
    let atom: String
    
    init(atom: String) {
        self.atom = atom
    }
    
    func getFormulaDescription() -> String {
        return "\(atom)"
    }
}
