//
//  gcdTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 15/01/2019.
//

import Testing
@testable import BigInt

@Suite struct GcdTests {

    func checkGcd(_ x: BInt, _ y: BInt) {
        let g = x.gcd(y)
        #expect(!g.isNegative)
        #expect(g == y.gcd(x))
        #expect(x.gcd(BInt.ZERO) == x.abs)
        #expect(x.gcd(BInt.ONE) == BInt.ONE)
        #expect(x.gcd(x) == x.abs)
        if g > 0 {
            precondition(g != 0)
            let (qx, rx) = x.quotientAndRemainder(dividingBy: g)
            let (qy, ry) = y.quotientAndRemainder(dividingBy: g)
            #expect(rx == BInt.ZERO)
            #expect(ry == BInt.ZERO)
            #expect(qx.gcd(qy) == BInt.ONE)
            #expect(qy.gcd(qx) == BInt.ONE)
        }
        #expect(x.gcd(x + 1) == BInt.ONE)
    }

    func checkGcdAllSigns(_ x: BInt, _ y: BInt) {
        checkGcd(x, y)
        checkGcd(-x, y)
        checkGcd(x, -y)
        checkGcd(-x, -y)
    }

    @Test func gcdVariousBitwidths() {
        var i = 1
        for _ in 0 ..< 4 {
            i *= 10
            for _ in 0 ..< 100 {
                let x = BInt(bitWidth: i)
                let y = BInt(bitWidth: 2 * i)
                checkGcdAllSigns(x, y)
                checkGcdAllSigns(x, BInt(Int.max))
                checkGcdAllSigns(x, BInt(Int.min))
                checkGcdAllSigns(x, BInt(Int.max) + 1)
                checkGcdAllSigns(x, BInt(Int.min) - 1)
            }
        }
    }

    @Test func gcdEdgeCases() {
        checkGcdAllSigns(BInt.ZERO, BInt.ZERO)
        checkGcdAllSigns(BInt.ZERO, BInt.ONE)
        checkGcdAllSigns(BInt.ONE, BInt.ONE)
    }

    @Test func gcdIntConsistency() {
        for _ in 0 ..< 3 {
            let x = BInt(bitWidth: 100)
            #expect(x.gcd(BInt.ZERO) == x.gcd(0))
            #expect(x.gcd(BInt.ONE) == x.gcd(1))
            #expect(x.gcd(BInt(Int.max)) == x.gcd(Int.max))
            #expect(x.gcd(BInt(Int.min)) == x.gcd(Int.min))
            #expect((-x).gcd(BInt.ZERO) == (-x).gcd(0))
            #expect((-x).gcd(BInt.ONE) == (-x).gcd(1))
            #expect((-x).gcd(BInt(Int.max)) == (-x).gcd(Int.max))
            #expect((-x).gcd(BInt(Int.min)) == (-x).gcd(Int.min))
        }
    }

    @Test func recursiveGcd() {
        var bw = BInt.RECURSIVE_GCD_LIMIT << 6
        for _ in 0 ..< 5 {
            let x = BInt(bitWidth: bw)
            let y = BInt(bitWidth: bw)
            #expect(x.recursiveGCD(y) == x.lehmerGCD(y))
            #expect(x.recursiveGCD(-y) == x.lehmerGCD(-y))
            #expect((-x).recursiveGCD(y) == (-x).lehmerGCD(y))
            #expect((-x).recursiveGCD(-y) == (-x).lehmerGCD(-y))
            bw *= 2
        }
    }
}
