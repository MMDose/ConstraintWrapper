# ConstraintWrapper.md

ConstraintWrapper is wrapper for UIKit constraint based System. It allows to create and manupulate with constraints easily.

## Features

- [x] Pure Swift 5.
- [x] Shorter constraint creation mechansim.
- [x] Fully support SafeArea, DimensionalMargin.
- [x] Manupulate with multiple constraints at same time.
- [x] 100% compatible with other Auto Layout code.


## Instalation
### ConstraintWrapper

ConstraintWrapper is available through [Swift Package Manager](https://swift.org/package-manager/). To install
it, in Xcode 11.0 or later select `File` > `Swift Packages` > `Add Package Dependency...` and add ConstraintWrapper repository URL:
```
https://github.com/MMDose/ConstraintWrapper.git
```

## Usage

Creating constraints with `NSLayoutConstraint`:

```swift
NSLayoutConstraint.activate([
    view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
    view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0),
    view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0),
    view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0)
])
```

with `ConstraintWrapper`:

```swift
view.addConstraint(sides: .all, constraint: .equal(constant: 0), respectSafeArea: true, activate: true)
```

or:

```swift
view.addConstraint(sides: .all, constraint: .equal(constant: 0), to: (superview, .all))
```

### Center
Constraining the center with `NSLayoutConstraint`:

```swift
NSLayoutConstraint.activate([
    view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 0)
    view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 0)
])
```

with `ConstraintWrapper`:

```swift
view.addConstraint(sides: [.centerX, .centerY], constraint: .equal(constant: 0),	activate: true)
```

or:

```swift
view.addConstraint(sides: [.centerX, .centerY], constraint: .equal(constant: 0), to: (superview, [.centerX, .centerY]))
```

### No additional Layers
You have an access for all Constraint the been created. Even complexes.
```
/// Easy one
let leadingConstraint = view.addConstraint(sides: .leading, constraint: .equal(constant: 0), activate: true)[.leading] /// NSLayoutConstraint

// Complex

let leadingConstraint = view.addConstraint(sides: [.leading, .top], constraint: .equal(constant: 0), to: (superview, [.trailing, .bottom]), activate: true)[.leading][.trailing]
/// returns NSLayoutConstraint leading>trailing

// or

let leadingConstraint = view.addConstraint(sides: [.leading, .top], constraint: .equal(constant: 0), to: (superview, [.trailing, .bottom]), activate: true)[.top][.bottom] 
/// returns NSLayoutConstraint top>bottom


```

### Be aware for invalid constraints
with `ConstraintWrapper`: you will receive runtime crash if constraints are not capable, instead of getting wrack UI.


