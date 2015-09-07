//
//  BitGenotype.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 15/07/15.
//  Copyright (c) 2015 Krzysztof Cieplucha. All rights reserved.
//

public class BitGenotype: Genotype<[Bit]> {
    
    public init(size: Int) {
        var genes = [Bit]()
        for _ in 0 ..< size {
            let gene = Int(arc4random_uniform(2))
            genes.append(Bit(rawValue: gene)!)
        }
        super.init(genes: genes)
    }
    
    public override init(genes: [Bit]) {
        super.init(genes: genes)
    }
    
    public override func cross(genotype: Genotype<[Bit]>) -> Genotype<[Bit]> {
        var newGenes = genes
        let index = Int(arc4random_uniform(UInt32(newGenes.count - 2))) + 1
        for i in index ..< newGenes.count {
            newGenes[i] = genotype.genes[i]
        }
        return BitGenotype(genes: newGenes)
    }
    
    public override func mutate() {
        let index = Int(arc4random_uniform(UInt32(genes.count)))
        genes[index] = genes[index] == .Zero ? .One : .Zero
    }
    
}
