//
//  FitnessFunction.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 14/07/15.
//  Copyright (c) 2015 Krzysztof Cieplucha. All rights reserved.
//

public class FitnessFunction<I, G> {
    
    public init() {}
    
    public func getMaxValue() -> Double {
        preconditionFailure("Failed invoking abstract function.")
    }
   
    public func getFitness(genotype genotype: Genotype<G>, fenotype: Fenotype<I ,G>) -> Double {
        preconditionFailure("Failed invoking abstract function.")
    }
    
}
