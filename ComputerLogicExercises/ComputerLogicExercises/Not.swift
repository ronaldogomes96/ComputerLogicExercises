//
//  Not.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Not: Formula {
    
    let atom: Formula
    
    init(atom: Formula) {
        self.atom = atom
    }
    
    func getFormulaDescription() -> String {
        return "(-\(atom.getFormulaDescription()))"
    }
    
}
