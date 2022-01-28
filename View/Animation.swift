//
//  Animation.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//


import SwiftUI

struct ShapeClipModifier<S: Shape>: ViewModifier {
    let shape: S
    
    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

extension AnyTransition {
    static var rectangular: AnyTransition { get {
        AnyTransition.modifier(
            active: ShapeClipModifier(shape: RectangularShape(pct: 1)),
            identity: ShapeClipModifier(shape: RectangularShape(pct: 0)))
        }
    }
    
    static var circular: AnyTransition { get {
        AnyTransition.modifier(
            active: ShapeClipModifier(shape: CircleClipShape(pct: 1)),
            identity: ShapeClipModifier(shape: CircleClipShape(pct: 0)))
        }
    }
    
    static var pentagrid: AnyTransition { get {
        AnyTransition.modifier(
            active: ShapeClipModifier(shape: RegularPolygon(sides: 5, pct: 1)),
            identity: ShapeClipModifier(shape: RegularPolygon(sides: 5, pct: 0)))
        }
    }
    
    static func stripes(stripes s: Int, horizontal h: Bool) -> AnyTransition {
        
        return AnyTransition.asymmetric(
            insertion: AnyTransition.modifier(
                active: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 1, stripes: s, horizontal: h)),
                identity: ShapeClipModifier(shape: StripesShape(insertion: true, pct: 0, stripes: s, horizontal: h))),
            removal: AnyTransition.modifier(
                active: ShapeClipModifier(shape: StripesShape(insertion: false, pct: 1, stripes: s, horizontal: h)),
                identity: ShapeClipModifier(shape: StripesShape(insertion: false, pct: 0, stripes: s, horizontal: h))))
    }
    
}

struct RectangularShape: Shape {
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(rect.insetBy(dx: pct * rect.width / 2.0, dy: pct * rect.height / 2.0))
        
        return path
    }
}

struct StripesShape: Shape {
    let insertion: Bool
    var pct: CGFloat
    let stripes: Int
    let horizontal: Bool
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        if horizontal {
            let stripeHeight = rect.height / CGFloat(stripes)
            
            for i in 0..<(stripes) {
                let j = CGFloat(i)

                if insertion {
                    path.addRect(CGRect(x: 0, y: j * stripeHeight, width: rect.width, height: stripeHeight * (1-pct)))
                } else {
                    path.addRect(CGRect(x: 0, y: j * stripeHeight + (stripeHeight * pct), width: rect.width, height: stripeHeight * (1-pct)))
                }
            }
        } else {
            let stripeWidth = rect.width / CGFloat(stripes)
            
            for i in 0..<(stripes) {
                let j = CGFloat(i)

                if insertion {
                    path.addRect(CGRect(x: j * stripeWidth, y: 0, width: stripeWidth * (1-pct), height: rect.height))
                } else {
                    path.addRect(CGRect(x: j * stripeWidth + (stripeWidth * pct), y: 0, width: stripeWidth * (1-pct), height: rect.height))
                }
            }
        }
        
        return path
    }
}

struct CircleClipShape: Shape {
    var pct: CGFloat

    var animatableData: CGFloat {
        get { pct  }
        set { pct = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        var bigRect = rect
        bigRect.size.width = bigRect.size.width * 2.5 * (1-pct)
        bigRect.size.height = bigRect.size.height * 2.5 * (1-pct)
        bigRect = bigRect.offsetBy(dx: -rect.width/1.2, dy: -rect.height/1.3)

        path = Circle().path(in: bigRect)

        return path
    }
}

public struct RegularPolygon: Shape {
    let sides: UInt
    var pct: CGFloat
    
    public var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path = .regularPolygon(sides: 5, in: rect, inset: pct)
        
        return path
    }
}

extension Path {
    static func regularPolygon(sides: UInt, in rect: CGRect, inset: CGFloat = 0) -> Path {
        let width = rect.size.width  * 3 * (1 - inset)
        let height = rect.size.height * 3 * (1 - inset)
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: width / 5.5, y: height / 5.5)
        
        return Path { path in
            (0...sides).forEach { index in
                let angle = ((Double(index) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                let point = CGPoint(
                    x: centerPoint.x + CGFloat(cos(angle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(angle) * hypotenuse)
                )
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
        }
        .offsetBy(dx: -20, dy: -30)
    }
}

