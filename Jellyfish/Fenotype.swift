//
//  Fenotype.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 07/07/15.
//  Copyright (c) 2015 Krzysztof Cieplucha. All rights reserved.
//

public class Fenotype<I, G> {
    
    public init() {}
    
    public func getIndividual(genotype genotype: Genotype<G>) -> I {
        preconditionFailure("Failed invoking abstract function.")
    }
    
    public func createRandomGenotype() -> Genotype<G> {
        preconditionFailure("Failed invoking abstract function.")
    }
    
}
