//
//  ViewSides.swift
//  Vozni
//
//  Created by Armen on 10/20/21.
//

import UIKit

public struct ViewSides: OptionSet, Hashable, Sequence {
    public var rawValue: Int

    public static let top: ViewSides = .init(rawValue: 1 << 0)
    public static let leading: ViewSides = .init(rawValue: 1 << 1)
    public static let trailing: ViewSides = .init(rawValue: 1 << 2)
    public static let bottom: ViewSides = .init(rawValue: 1 << 3)
    public static let centerX: ViewSides = .init(rawValue: 1 << 4)
    public static let centerY: ViewSides = .init(rawValue: 1 << 5)
    public static let height: ViewSides = .init(rawValue: 1 << 6)
    public static let width: ViewSides = .init(rawValue: 1 << 7)
    public static let all: ViewSides = [[.top, .bottom], [.leading, .trailing]]

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension ViewSides {
    var isCapable: Bool {
        guard !self.contains(.all) else {
            return true
        }

        return self.isDisjoint(with: [.top, .leading]) ||
            self.isDisjoint(with: [.top, .trailing]) ||
            self.isDisjoint(with: [.bottom, .trailing]) ||
            self.isDisjoint(with: [.bottom, .leading]) ||
            self.isDisjoint(with: [.height, .all])
    }

    var isAnchorX: Bool {
        self.isDisjoint(with: [.width, .height, .centerY, .bottom, .top])
    }

    var isAnchorY: Bool {
        self.isDisjoint(with: [.leading, .trailing, .width, .height, .centerX])
    }

    var isDimension: Bool {
        self.isDisjoint(with: [.leading, .trailing, .width, .height, .centerY, .centerX, .top, .bottom])
    }

    func acnhorX(guid: UILayoutGuide) -> NSLayoutAnchor<NSLayoutXAxisAnchor>? {
        switch self {
        case .trailing:
            return guid.trailingAnchor
        case .leading:
            return guid.leadingAnchor
        case .centerX:
            return guid.centerXAnchor
        default:
            return nil
        }
    }

    func acnhorY(guid: UILayoutGuide) -> NSLayoutAnchor<NSLayoutYAxisAnchor>? {
        switch self {
        case .top:
            return guid.topAnchor
        case .bottom:
            return guid.bottomAnchor
        case .centerY:
            return guid.centerYAnchor
        default:
            return nil
        }
    }

    func dimension(guid: UILayoutGuide) -> NSLayoutDimension? {
        switch self {
        case .height:
            return guid.heightAnchor
        case .width:
            return guid.widthAnchor
        default:
            return nil
        }
    }

    func equivalentValue(insent: UIEdgeInsets) -> CGFloat {
        switch self {
        case .leading:
            return insent.left
        case .trailing:
            return insent.right
        case .top:
            return insent.top
        case .bottom:
            return insent.bottom
        default:
            return 0
        }
    }
}
