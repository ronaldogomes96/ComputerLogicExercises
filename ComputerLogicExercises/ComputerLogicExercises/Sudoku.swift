//
//  Sudoku.swift
//  ComputerLogicExercises
//
//  Created by Ronaldo Gomes on 12/12/20.
//

import Foundation

class Sudoku {
    let myGrid = [[2,1,4,3],
                  [4,3,2,1],
                  [1,2,3,4],
                  [3,4,1,2]]
    let myGrid2 = [[0,1,4,3],
                   [4,3,2,0],
                   [1,0,3,4],
                   [3,4,1,0]]
    
    func givenDigitsConstraints(grid: [[Int]]) -> Formula {
        var list_given = [Formula]()
        for i in 0..<grid.count {
            for j in 0..<grid.count {
                if grid[i][j] != 0 {
                    list_given.append(Atom("\(String(i+1))_\(String(j+1))_\(String(grid[i][j]))"))
                    for n in 1...grid.count+1 {
                        if n != grid[i][j] {
                            list_given.append(Not(Atom("\(String(i+1))_\(String(j+1))_\(String(n))")))
                        }
                    }
                }
            }
        }
        return andAll(listOfFormulas: list_given)
    }
    
    func andAll(listOfFormulas: [Formula]) -> Formula {
        var firstFormula = listOfFormulas[0]
        var newListOfFormulas = listOfFormulas
        newListOfFormulas.remove(at: 0)
        newListOfFormulas.forEach { (formula) in
            firstFormula = And(firstFormula, formula)
        }
        return firstFormula
    }
    
    func rowConstraints(grid: [[Int]]) -> Formula {
        var listRows = [Formula]()
        for i in 0...grid.count {
            for n in 0...grid.count {
                var orList = [Formula]()
                for j in 0...grid.count {
                    orList.append(Atom("\(String(i+1))_\(String(j+1))_\(String(n+1))"))
                }
                let formulaOr = orAll(listOfFormulas: orList)
                listRows.append(formulaOr)
            }
        }
        return andAll(listOfFormulas: listRows)
    }
    
    func orAll(listOfFormulas: [Formula]) -> Formula {
        var firstFormula = listOfFormulas[0]
        var newListOfFormulas = listOfFormulas
        newListOfFormulas.remove(at: 0)
        newListOfFormulas.forEach { (formula) in
            firstFormula = Or(firstFormula, formula)
        }
        return firstFormula
    }
    
    func cellsConstraints(grid: [[Int]]) -> Formula {
        var listCells = [Formula]()
        for i in 0...grid.count {
            for j in 0...grid.count {
                for n1 in 0...grid.count - 1 {
                    for n2 in n1+1...grid.count {
                        listCells.append(Not(And(Atom("\(String(i+1))_\(String(j+1))_\(String(n1+1))"),
                                                 Atom("\(String(i+1))_\(String(j+1))_\(String(n2+1))"))))
                    }
                }
            }
        }
        return andAll(listOfFormulas: listCells)
    }
    
    func columnsConstraints(grid: [[Int]]) -> Formula {
        var listColumns = [Formula]()
        for j in 0...grid.count {
            for n in 0...grid.count {
                var orList = [Formula]()
                for i in 0...grid.count {
                    orList.append(Atom("\(String(i+1))_\(String(j+1))_\(String(n+1))"))
                }
                let formulaOr = orAll(listOfFormulas: orList)
                listColumns.append(formulaOr)
            }
        }
        return andAll(listOfFormulas: listColumns)
    }
    
    func subgridsConstrains(grid: [[Int]]) -> Formula {
        var subgridFormula = [Formula]()
        for sl in 0...(Int(sqrt(Double(grid.count)))) {
            for sc in 0...(Int(sqrt(Double(grid.count)))) {
                for n in 0...grid.count {
                    var orList = [Formula]()
                    for i in 0...(Int(sqrt(Double(grid.count)))) {
                        for j in 0...(Int(sqrt(Double(grid.count)))) {
                            orList.append(Atom("\(String(sl*2+i+1))_\(String(sc*2+j+1))_\(String(n+1))"))
                        }
                    }
                    let formulaOr = orAll(listOfFormulas: orList)
                    subgridFormula.append(formulaOr)
                }
            }
        }
        return andAll(listOfFormulas: subgridFormula)
    }
    
    func finalFormula() -> Formula {
        return And(
            And(
                And(
                    givenDigitsConstraints(grid: myGrid),
                    rowConstraints(grid: myGrid)),
                And(
                    cellsConstraints(grid: myGrid),
                    columnsConstraints(grid: myGrid)
                )
            ),
            subgridsConstrains(grid: myGrid)
        )
    }
    
    func sudokuSolution(grid: [[Int]]) -> [[Int]] {
        var mygrid = grid
        let fn = Functions()
        guard let solution = fn.satisfabilityChecking(formula: finalFormula()) as? [String: Bool] else {
            print(fn.satisfabilityChecking(formula: finalFormula()))
            return [[0]]
        }
        //let solution = [String: Bool]()
        for i in 0...grid.count {
            for j in 0...grid.count {
                if grid[i][j] == 0 {
                    for n in 0...grid.count {
                        if solution["\(String(i+1))_\(String(j+1))_\(String(n+1))"]! {
                            mygrid[i][j] = n + 1
                            break
                        }
                    }
                }
            }
        }
        return mygrid
    }
}
