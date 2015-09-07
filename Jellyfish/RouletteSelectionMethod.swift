//
//  RouletteSelectionMethod.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 31/07/15.
//  Copyright © 2015 Krzysztof Cieplucha. All rights reserved.
//

public class RouletteSelectionMethod: SelectionMethod {

    public override func select(items: [Double], sum: Double) -> Int {
        let random = Double(arc4random_uniform(1000))
        var value = sum * random / 1000
        
        for i in 0 ..< items.endIndex {
            value -= items[i]
            if value <= 0 { return i }
        }
        
        return items.endIndex - 1
    }
    
}
