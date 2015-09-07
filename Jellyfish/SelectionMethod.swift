//
//  SelectionMethod.swift
//  Jellyfish
//
//  Created by Krzysztof Cieplucha on 31/07/15.
//  Copyright © 2015 Krzysztof Cieplucha. All rights reserved.
//

public class SelectionMethod {
    
    public init() {}
    
    public func select(items: [Double], sum: Double) -> Int {
        preconditionFailure("Failed invoking abstract function.")
    }
    
}
