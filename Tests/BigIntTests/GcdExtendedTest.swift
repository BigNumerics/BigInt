//
//  GcdExtendedTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 05/08/2022.
//

import Testing
@testable import BigInt

@Suite struct GcdExtendedTests {

    func checkExtendedGcdBInt(_ a: BInt, _ b: BInt) {
        let g1 = a.gcd(b)
        let g2 = a.gcd(-b)
        let g3 = (-a).gcd(b)
        let g4 = (-a).gcd(-b)
        let (ge1, x1, y1) = a.gcdExtended(b)
        let (ge2, x2, y2) = a.gcdExtended(-b)
        let (ge3, x3, y3) = (-a).gcdExtended(b)
        let (ge4, x4, y4) = (-a).gcdExtended(-b)
        #expect(g1 == ge1)
        #expect(g2 == ge2)
        #expect(g3 == ge3)
        #expect(g4 == ge4)
        #expect(g1 == a * x1 + b * y1)
        if g1.isNotZero {
            #expect(x1.abs <= (b / g1).abs || a == 0 || b == 0)
            #expect(y1.abs <= (a / g1).abs || a == 0 || b == 0)
        }
        #expect(g2 == a * x2 + (-b) * y2)
        if g2.isNotZero {
            #expect(x2.abs <= (b / g2).abs || a == 0 || b == 0)
            #expect(y2.abs <= (a / g2).abs || a == 0 || b == 0)
        }
        #expect(g3 == (-a) * x3 + b * y3)
        if g3.isNotZero {
            #expect(x3.abs <= (b / g3).abs || a == 0 || b == 0)
            #expect(y3.abs <= (a / g3).abs || a == 0 || b == 0)
        }
        #expect(g4 == (-a) * x4 + (-b) * y4)
        if g4.isNotZero {
            #expect(x4.abs <= (b / g4).abs || a == 0 || b == 0)
            #expect(y4.abs <= (a / g4).abs || a == 0 || b == 0)
        }
    }

    func checkExtendedGcdInt(_ a: BInt, _ b: Int) {
        let g1 = a.gcd(b)
        let g2 = a.gcd(-b)
        let g3 = (-a).gcd(b)
        let g4 = (-a).gcd(-b)
        let (ge1, x1, y1) = a.gcdExtended(b)
        let (ge2, x2, y2) = a.gcdExtended(-b)
        let (ge3, x3, y3) = (-a).gcdExtended(b)
        let (ge4, x4, y4) = (-a).gcdExtended(-b)
        #expect(g1 == ge1)
        #expect(g2 == ge2)
        #expect(g3 == ge3)
        #expect(g4 == ge4)
        #expect(g1 == a * x1 + b * y1)
        if g1.isNotZero {
            #expect(x1.abs <= (b / g1).abs || a == 0 || b == 0)
            #expect(y1.abs <= (a / g1).abs || a == 0 || b == 0)
        }
        #expect(g2 == a * x2 + (-b) * y2)
        if g2.isNotZero {
            #expect(x2.abs <= (b / g2).abs || a == 0 || b == 0)
            #expect(y2.abs <= (a / g2).abs || a == 0 || b == 0)
        }
        #expect(g3 == (-a) * x3 + b * y3)
        if g3.isNotZero {
            #expect(x3.abs <= (b / g3).abs || a == 0 || b == 0)
            #expect(y3.abs <= (a / g3).abs || a == 0 || b == 0)
        }
        #expect(g4 == (-a) * x4 + (-b) * y4)
        if g4.isNotZero {
            #expect(x4.abs <= (b / g4).abs || a == 0 || b == 0)
            #expect(y4.abs <= (a / g4).abs || a == 0 || b == 0)
        }
    }

    @Test func extendedGcdBInt() {
        checkExtendedGcdBInt(BInt.ZERO, BInt.ZERO)
        checkExtendedGcdBInt(BInt.ZERO, BInt.ONE)
        checkExtendedGcdBInt(BInt.ONE, BInt.ZERO)
        checkExtendedGcdBInt(BInt.ONE, BInt.ONE)
        for _ in 0 ..< 100 {
            let a = BInt(bitWidth: 100)
            checkExtendedGcdBInt(a, BInt.ZERO)
            checkExtendedGcdBInt(a, BInt.ONE)
            checkExtendedGcdBInt(a, BInt.TWO)
            for _ in 0 ..< 100 {
                let b = BInt(bitWidth: 100)
                checkExtendedGcdBInt(a, b)
            }
        }
    }

    @Test func extendedGcdInt() {
        checkExtendedGcdInt(BInt.ZERO, 0)
        checkExtendedGcdInt(BInt.ZERO, 1)
        checkExtendedGcdInt(BInt.ONE, 0)
        checkExtendedGcdInt(BInt.ONE, 1)
        for _ in 0 ..< 100 {
            let a = BInt(bitWidth: 100)
            checkExtendedGcdInt(a, 0)
            checkExtendedGcdInt(a, 1)
            checkExtendedGcdInt(a, 2)
            for _ in 0 ..< 100 {
                let b = BInt(bitWidth: 60).asInt()!
                checkExtendedGcdInt(a, b)
            }
        }
    }

    func checkRecursiveGcd(_ x: BInt, _ y: BInt) {
        var (g1, a1, b1) = x.recursiveGCDext(y)
        var (g2, a2, b2) = x.lehmerGCDext(y)
        #expect(g1 == g2)
        #expect(a1 == a2)
        #expect(b1 == b2)
        #expect(g1 == a1 * x + b1 * y)
        (g1, a1, b1) = x.recursiveGCDext(-y)
        (g2, a2, b2) = x.lehmerGCDext(-y)
        #expect(g1 == g2)
        #expect(a1 == a2)
        #expect(b1 == b2)
        #expect(g1 == a1 * x + b1 * (-y))
        (g1, a1, b1) = (-x).recursiveGCDext(y)
        (g2, a2, b2) = (-x).lehmerGCDext(y)
        #expect(g1 == g2)
        #expect(a1 == a2)
        #expect(b1 == b2)
        #expect(g1 == a1 * (-x) + b1 * y)
        (g1, a1, b1) = (-x).recursiveGCDext(-y)
        (g2, a2, b2) = (-x).lehmerGCDext(-y)
        #expect(g1 == g2)
        #expect(a1 == a2)
        #expect(b1 == b2)
        #expect(g1 == a1 * (-x) + b1 * (-y))
    }

    @Test func recursiveGcd() {
        var bw = BInt.RECURSIVE_GCD_EXT_LIMIT << 6
        for _ in 0 ..< 5 {
            let x = BInt(bitWidth: bw)
            let y = BInt(bitWidth: bw)
            checkRecursiveGcd(x, y)
            checkRecursiveGcd(x * y, y)
            checkRecursiveGcd(x, x * y)
            bw *= 2
        }
    }

}
