//
//  IntMinMaxTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 09/10/2021.
//

import Testing
@testable import BigInt

@Suite struct IntMinMaxTests {

    @Test func intMinMaxAddition() {
        #expect(BInt(11) + Int.max == BInt(11) + BInt(Int.max))
        #expect(Int.max + BInt(11) == BInt(Int.max) + BInt(11))
        var x = BInt(11)
        x += Int.max
        #expect(x == BInt(11) + BInt(Int.max))
        #expect(BInt(11) + Int.min == BInt(11) + BInt(Int.min))
        #expect(Int.min + BInt(11) == BInt(Int.min) + BInt(11))
        x = BInt(11)
        x += Int.min
        #expect(x == BInt(11) + BInt(Int.min))
    }

    @Test func intMinMaxSubtraction() {
        #expect(BInt(11) - Int.max == BInt(11) - BInt(Int.max))
        #expect(Int.max - BInt(11) == BInt(Int.max) - BInt(11))
        var x = BInt(11)
        x -= Int.max
        #expect(x == BInt(11) - BInt(Int.max))
        #expect(BInt(11) - Int.min == BInt(11) - BInt(Int.min))
        #expect(Int.min - BInt(11) == BInt(Int.min) - BInt(11))
        x = BInt(11)
        x -= Int.min
        #expect(x == BInt(11) - BInt(Int.min))
    }

    @Test func intMinMaxMultiplication() {
        #expect(BInt(7) * Int.max == BInt(7) * BInt(Int.max))
        #expect(BInt(7) * Int.min == BInt(7) * BInt(Int.min))
        #expect(BInt(-7) * Int.max == BInt(-7) * BInt(Int.max))
        #expect(BInt(-7) * Int.min == BInt(-7) * BInt(Int.min))
        #expect(BInt(0) * Int.max == BInt(0))
        #expect(BInt(0) * Int.min == BInt(0))
        #expect(Int.max * BInt(7) == BInt(7) * BInt(Int.max))
        #expect(Int.min * BInt(7) == BInt(7) * BInt(Int.min))
        #expect(Int.max * BInt(-7) == BInt(-7) * BInt(Int.max))
        #expect(Int.min * BInt(-7) == BInt(-7) * BInt(Int.min))
        #expect(Int.max * BInt(0) == BInt(0))
        #expect(Int.min * BInt(0) == BInt(0))
    }

    @Test func intMinMaxDivision() {
        let x = BInt.ONE << 1000
        #expect(x / Int.max == x / BInt(Int.max))
        #expect(x / Int.min == x / BInt(Int.min))
        #expect(-x / Int.max == -x / BInt(Int.max))
        #expect(-x / Int.min == -x / BInt(Int.min))
        #expect(BInt(0) / Int.max == BInt(0))
        #expect(BInt(0) / Int.min == BInt(0))
    }

    @Test func intMinMaxIdentities() {
        #expect(BInt(Int.max) - BInt(Int.max) == BInt(0))
        #expect(BInt(Int.max) - Int.max == BInt(0))
        #expect(Int.max - BInt(Int.max) == BInt(0))
        #expect(BInt(Int.min) - BInt(Int.min) == BInt(0))
        #expect(BInt(Int.min) - Int.min == BInt(0))
        #expect(Int.min - BInt(Int.min) == BInt(0))
        #expect(BInt(Int.max) + BInt(Int.min) == BInt(-1))
        #expect(BInt(Int.max) + Int.min == BInt(-1))
        #expect(Int.max + BInt(Int.min) == BInt(-1))
        #expect(BInt(Int.max).asInt()! == Int.max)
        #expect(BInt(Int.min).asInt()! == Int.min)
    }

}
