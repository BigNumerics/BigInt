//
//  AdditionTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 17/01/2019.
//

import Testing
@testable import BigInt

@Suite struct AdditionTests {

    @Test func basicAddition() {
        #expect(BInt(7) + BInt(4) == BInt(11))
        #expect(BInt(7) + BInt(-4) == BInt(3))
        #expect(BInt(-7) + BInt(4) == BInt(-3))
        #expect(BInt(-7) + BInt(-4) == BInt(-11))
        #expect(BInt(-7) + BInt(0) == BInt(-7))
        #expect(BInt(7) + BInt(0) == BInt(7))
        #expect(BInt(7) + 4 == BInt(11))
        #expect(BInt(7) + (-4) == BInt(3))
        #expect(BInt(-7) + 4 == BInt(-3))
        #expect(BInt(-7) + (-4) == BInt(-11))
        #expect(BInt(-7) + 0 == BInt(-7))
        #expect(BInt(7) + 0 == BInt(7))
        #expect(7 + BInt(4) == BInt(11))
        #expect(7 + BInt(-4) == BInt(3))
        #expect((-7) + BInt(4) == BInt(-3))
        #expect((-7) + BInt(-4) == BInt(-11))
        #expect((-7) + BInt(0) == BInt(-7))
        #expect(7 + BInt(0) == BInt(7))
        #expect(0 + BInt(7) == BInt(7))
        #expect(0 + BInt(-7) == BInt(-7))
        #expect(0 + BInt(0) == BInt(0))
    }

    @Test func compoundAddition() {
        var x1 = BInt(7)
        x1 += BInt(4)
        #expect(x1 == BInt(11))
        var x2 = BInt(7)
        x2 += BInt(-4)
        #expect(x2 == BInt(3))
        var x3 = BInt(-7)
        x3 += BInt(4)
        #expect(x3 == BInt(-3))
        var x4 = BInt(-7)
        x4 += BInt(-4)
        #expect(x4 == BInt(-11))
    }

    @Test func additionSubtractionIdentity() {
        for i in 0 ..< 1000 {
            let a = i % 2 == 0 ? BInt(bitWidth: 1000) : -BInt(bitWidth: 1000)
            let b = BInt(bitWidth: 800)
            let n = BInt(bitWidth: 500)
            let ab = a + b
            let an = a * n
            #expect(ab - a == b)
            #expect(ab - b == a)
            #expect(an - a == a * (n - 1))
        }
    }

    @Test func repeatedAddition() {
        for i in 0 ..< 1000 {
            let a = i % 2 == 0 ? BInt(bitWidth: 1000) : -BInt(bitWidth: 1000)
            var b = a
            for _ in 0 ..< 100 {
                b += a
            }
            #expect(b == a * 101)
        }
    }

    func checkIntAddition(_ x: BInt, _ y: Int) {
        #expect(x + y == x + BInt(y))
        #expect((-x) + y == (-x) + BInt(y))
        if y != Int.min {
            #expect(x + (-y) == x + BInt(-y))
            #expect((-x) + (-y) == (-x) + BInt(-y))
        }
    }

    func checkIntAdditionCases(_ x: BInt) {
        checkIntAddition(x, 0)
        checkIntAddition(x, 1)
        checkIntAddition(x, -1)
        checkIntAddition(x, Int.max)
        checkIntAddition(x, Int.min)
        checkIntAddition(x, Int.max - 1)
        checkIntAddition(x, Int.min + 1)
    }

    @Test func intAdditionConsistency() {
        checkIntAdditionCases(BInt(bitWidth: 1000))
        checkIntAdditionCases(BInt(0))
        checkIntAdditionCases(BInt(1))
        checkIntAdditionCases(BInt(-1))
        checkIntAdditionCases(BInt(Int.max))
        checkIntAdditionCases(-BInt(Int.max))
        checkIntAdditionCases(BInt(Int.min))
        checkIntAdditionCases(-BInt(Int.min))
    }
}
