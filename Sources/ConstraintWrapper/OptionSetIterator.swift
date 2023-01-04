//
//  OptionSetIterator.swift
//  Vozni
//
//  Created by Armen on 10/20/21.
//

import UIKit

public typealias OptionSetSequence = OptionSet & Sequence

public struct OptionSetIterator<Element: OptionSet>: IteratorProtocol where Element.RawValue: FixedWidthInteger {

    private let element: Element
    private lazy var remindingBites = self.element.rawValue
    private var bitMask: Self.Element.RawValue = 1

    public init(element: Element) {
        self.element = element
    }

    public mutating func next() -> Element? {
        while remindingBites != 0 {
            defer { bitMask = bitMask &* 2 }
            if remindingBites & bitMask != 0 {
                remindingBites = remindingBites & ~bitMask
                return Element(rawValue: bitMask)
            }
        }
        return nil
    }
}

public extension OptionSet where Self.RawValue: FixedWidthInteger {
    func makeIterator() -> OptionSetIterator<Self> {
        return OptionSetIterator(element: self)
    }
}
