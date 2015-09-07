//
//  Simulation.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 14/07/15.
//  Copyright (c) 2015 Krzysztof Cieplucha. All rights reserved.
//

public class Simulation<I, G> {
    
    typealias Representant = (genotype: Genotype<G>, fitnessValue: Double)
    typealias Population = [Representant]
    
    let fenotype: Fenotype<I, G>
    let fitnessFunction: FitnessFunction<I, G>
    let selectionMethod: SelectionMethod
    
    let numberOfPopulations: Int
    let numberOfRepresentatives: Int
    private(set) var populations = [Population]()
   
    public init(fenotype: Fenotype<I, G>, fitnessFunction: FitnessFunction<I, G>, selectionMethod: SelectionMethod, numberOfPopulations: Int, numberOfRepresentatives: Int) {
        self.fenotype = fenotype
        self.fitnessFunction = fitnessFunction
        self.selectionMethod = selectionMethod
        
        self.numberOfPopulations = numberOfPopulations
        self.numberOfRepresentatives = numberOfRepresentatives
        
        for _ in 0 ..< numberOfPopulations {
            populations.append(self.generatePopulation())
        }
    }
    
    public convenience init(fenotype: Fenotype<I, G>, fitnessFunction: FitnessFunction<I, G>, selectionMethod: SelectionMethod) {
        self.init(fenotype: fenotype, fitnessFunction: fitnessFunction, selectionMethod: selectionMethod, numberOfPopulations: 8, numberOfRepresentatives: 16)
    }
    
    public func step() {
        var newPopulations = [Population]()
        for population in populations {
            newPopulations.append(self.generateNextPopulation(population))
        }
        
        //migration
        let genotype = fenotype.createRandomGenotype()
        let worstRepresentantIndex = self.getWorstRepresentantIndex(newPopulations[0])
        newPopulations[0][worstRepresentantIndex].genotype = genotype
        newPopulations[0][worstRepresentantIndex].fitnessValue = fitnessFunction.getFitness(genotype: genotype, fenotype: fenotype)
        
        for i in 1 ..< numberOfPopulations {
            let bestRepresentantIndex = self.getBestRepresentantIndex(newPopulations[i - 1])
            let bestRepresentantFitnessValue = newPopulations[i - 1][bestRepresentantIndex].fitnessValue
            let treshold = fitnessFunction.getMaxValue() * Double(i) / Double(numberOfPopulations)
            if bestRepresentantFitnessValue > treshold {
                let worstRepresentantIndex = self.getWorstRepresentantIndex(newPopulations[i])
                newPopulations[i][worstRepresentantIndex] = newPopulations[i - 1][bestRepresentantIndex]
            }
        }
        
        populations = newPopulations
    }
    
    public func getBestGenotype() -> Genotype<G> {
        let bestPopulation = populations[numberOfPopulations - 1]
        return bestPopulation[self.getBestRepresentantIndex(bestPopulation)].genotype
    }
    
    private func generatePopulation() -> Population {
        var population = [Representant]() as Population
        for _ in 0 ..< numberOfRepresentatives {
            let genotype = fenotype.createRandomGenotype()
            let fitnessValue = fitnessFunction.getFitness(genotype: genotype, fenotype: fenotype)
            population.append(genotype: genotype, fitnessValue: fitnessValue)
        }
        return population
    }
    
    private func generateNextPopulation(population: Population) -> Population {
        var fitnessValues = [Double]()
        var populationFitnessValue = 0.0
        for representative in population {
            let fitnessValue = representative.fitnessValue
            fitnessValues.append(fitnessValue)
            populationFitnessValue += fitnessValue
        }
        
        var newPopulation = [Representant]() as Population
        for _ in 0 ..< numberOfRepresentatives {
            let mother = population[selectionMethod.select(fitnessValues, sum: populationFitnessValue)]
            let father = population[selectionMethod.select(fitnessValues, sum: populationFitnessValue)]
            let childGenotype = mother.genotype.cross(father.genotype)
            if arc4random_uniform(100) == 1 {
                childGenotype.mutate()
            }
            let fitnessValue = fitnessFunction.getFitness(genotype: childGenotype, fenotype: fenotype)
            newPopulation.append(genotype: childGenotype, fitnessValue: fitnessValue)
        }
        
        return newPopulation
    }
    
    private func getWorstRepresentantIndex(population: Population) -> Int {
        var worstRepresentantIndex = 0
        var worstRepresentantFitnessValue = population[0].fitnessValue
        for i in 1 ..< population.endIndex {
            if worstRepresentantFitnessValue > population[i].fitnessValue {
                worstRepresentantIndex = i
                worstRepresentantFitnessValue = population[i].fitnessValue
            }
        }
        return worstRepresentantIndex
    }
    
    private func getBestRepresentantIndex(population: Population) -> Int {
        var bestRepresentantIndex = 0
        var bestRepresentantFitnessValue = population[0].fitnessValue
        for i in 1 ..< population.endIndex {
            if bestRepresentantFitnessValue < population[i].fitnessValue {
                bestRepresentantIndex = i
                bestRepresentantFitnessValue = population[i].fitnessValue
            }
        }
        return bestRepresentantIndex
    }
    
}
