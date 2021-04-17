//
//  Not.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 21/11/20.
//

import Foundation

class Not: Formula {
    
    let inner: Formula
    
    init(_ atom: Formula) {
        self.inner = atom
    }
    
    func getFormulaDescription() -> String {
        return "-\(inner.getFormulaDescription())"
    }
    
}
