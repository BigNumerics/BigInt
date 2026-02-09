//
//  ToStringTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 04/02/2019.
//

import Testing
@testable import BigInt

@Suite struct ToStringTests {

    @Test func toStringPowersOfTen() {
        var x = BInt(1)
        var s = "1"
        for _ in 0 ..< 100 {
            x *= 10
            s += "0"
            #expect(s == x.asString(radix: 10))
        }
    }

    @Test func toStringRadixPositive() {
        let x: Limbs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let b = BInt(x, false)
        for r in 2 ... 36 {
            let b1 = BInt(b.asString(radix: r), radix: r)
            #expect(b == b1)
        }
    }

    @Test func toStringRadixNegative() {
        let x: Limbs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let b = BInt(x, true)
        for r in 2 ... 36 {
            let b1 = BInt(b.asString(radix: r), radix: r)
            #expect(b == b1)
        }
    }

    @Test func toStringRoundtrip() {
        var bw = 10
        for _ in 0 ..< 10 {
            for _ in 0 ..< 100 {
                let x = BInt(bitWidth: bw)
                #expect(x == BInt(x.asString())!)
                #expect(-x == BInt((-x).asString())!)
            }
            bw *= 2
        }
    }

}
