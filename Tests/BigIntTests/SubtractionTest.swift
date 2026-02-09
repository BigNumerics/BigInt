//
//  SubtractionTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 19/01/2019.
//

import Testing
@testable import BigInt

@Suite struct SubtractionTests {

    @Test func basicSubtraction() {
        #expect(BInt(7) - BInt(4) == BInt(3))
        #expect(BInt(7) - BInt(-4) == BInt(11))
        #expect(BInt(-7) - BInt(4) == BInt(-11))
        #expect(BInt(-7) - BInt(-4) == BInt(-3))
        #expect(BInt(-7) - BInt(0) == BInt(-7))
        #expect(BInt(7) - BInt(0) == BInt(7))
        #expect(BInt(7) - 4 == BInt(3))
        #expect(BInt(7) - (-4) == BInt(11))
        #expect(BInt(-7) - 4 == BInt(-11))
        #expect(BInt(-7) - (-4) == BInt(-3))
        #expect(BInt(-7) - 0 == BInt(-7))
        #expect(BInt(7) - 0 == BInt(7))
        #expect(7 - BInt(4) == BInt(3))
        #expect(7 - BInt(-4) == BInt(11))
        #expect((-7) - BInt(4) == BInt(-11))
        #expect((-7) - BInt(-4) == BInt(-3))
        #expect((-7) - BInt(0) == BInt(-7))
        #expect(7 - BInt(0) == BInt(7))
        #expect(0 - BInt(7) == BInt(-7))
        #expect(0 - BInt(-7) == BInt(7))
        #expect(0 - BInt(0) == BInt(0))
    }

    @Test func compoundSubtraction() {
        var x1 = BInt(7)
        x1 -= BInt(4)
        #expect(x1 == BInt(3))
        var x2 = BInt(7)
        x2 -= BInt(-4)
        #expect(x2 == BInt(11))
        var x3 = BInt(-7)
        x3 -= BInt(4)
        #expect(x3 == BInt(-11))
        var x4 = BInt(-7)
        x4 -= BInt(-4)
        #expect(x4 == BInt(-3))
    }

    func checkIntSubtraction(_ x: BInt, _ y: Int) {
        #expect(x - y == x - BInt(y))
        #expect((-x) - y == (-x) - BInt(y))
        if y != Int.min {
            #expect(x - (-y) == x - BInt(-y))
            #expect((-x) - (-y) == (-x) - BInt(-y))
        }
    }

    func checkIntSubtractionCases(_ x: BInt) {
        checkIntSubtraction(x, 0)
        checkIntSubtraction(x, 1)
        checkIntSubtraction(x, -1)
        checkIntSubtraction(x, Int.max)
        checkIntSubtraction(x, Int.min)
        checkIntSubtraction(x, Int.max - 1)
        checkIntSubtraction(x, Int.min + 1)
    }

    @Test func intSubtractionConsistency() {
        checkIntSubtractionCases(BInt(bitWidth: 1000))
        checkIntSubtractionCases(BInt(0))
        checkIntSubtractionCases(BInt(1))
        checkIntSubtractionCases(BInt(-1))
        checkIntSubtractionCases(BInt(Int.max))
        checkIntSubtractionCases(-BInt(Int.max))
        checkIntSubtractionCases(BInt(Int.min))
        checkIntSubtractionCases(-BInt(Int.min))
    }

}
