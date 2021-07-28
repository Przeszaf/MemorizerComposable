//
//  Array.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 28/07/2021.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
