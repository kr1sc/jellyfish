//
//  Genotype.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 14/07/15.
//  Copyright (c) 2015 Krzysztof Cieplucha. All rights reserved.
//

public class Genotype<G> {
    
    public var genes: G
    
    public init(genes: G) {
        self.genes = genes
    }
    
    public func cross(genotype: Genotype<G>) -> Genotype<G> {
        preconditionFailure("Failed invoking abstract function.")
    }
    
    public func mutate() {
        preconditionFailure("Failed invoking abstract function.")
    }
   
}
