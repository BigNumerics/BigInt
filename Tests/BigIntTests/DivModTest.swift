//
//  DivModTest.swift
//  XBigIntegerTests
//
//  Created by Leif Ibsen on 11/12/2018.
//

import Testing
@testable import BigInt

@Suite struct DivModTests {

    func checkRandomDivMod(_ bw1: Int, _ bw2: Int) {
        let x1 = BInt(bitWidth: bw1)
        let x2 = BInt(bitWidth: bw2) + BInt.ONE
        checkDivMod(x1, x2)
    }

    func checkDivMod(_ x1: BInt, _ x2: BInt) {
        let r1 = x1 % x2
        let q1 = x1 / x2
        #expect(x1 == x2 * q1 + r1)
        #expect(r1.abs < x2.abs)
        let (q2, r2) = x1.quotientAndRemainder(dividingBy: x2)
        #expect(q1 == q2)
        #expect(r1 == r2)
        var q3 = BInt.ZERO
        var r3 = BInt.ZERO
        x1.quotientAndRemainder(dividingBy: x2, &q3, &r3)
        #expect(q1 == q3)
        #expect(r1 == r3)
        #expect(x1.mod(Int.min) == x1.mod(BInt(Int.min)).asInt()!)
    }

    func checkIntDivisor(_ x1: BInt, _ x2: Int) {
        let (q1, r1) = x1.quotientAndRemainder(dividingBy: x2)
        let (q2, r2) = x1.quotientAndRemainder(dividingBy: BInt(x2))
        #expect(q1 == q2)
        #expect(r1 == r2.asInt()!)
        #expect(x1 / x2 == x1 / BInt(x2))
        #expect(x1 % x2 == x1 % BInt(x2))
        #expect(x1.mod(x2) == x1.mod(BInt(x2)).asInt()!)
    }

    @Test func divModVariousBitwidths() {
        checkRandomDivMod(30, 20)
        checkRandomDivMod(30, 120)
        checkRandomDivMod(130, 20)
        checkRandomDivMod(130, 120)
        checkDivMod(BInt.ONE << 512 - 1, BInt.ONE)
        checkDivMod(BInt.ONE << 512 - 1, BInt.ONE << 512 - 1)
        checkDivMod(BInt.ONE << 512, BInt.ONE)
        checkDivMod(BInt.ONE << 512, BInt.ONE << 512 - 1)
    }

    @Test func modOperator() {
        #expect(BInt(7) % BInt(4) == BInt(3))
        #expect(BInt(-7) % BInt(4) == BInt(-3))
        #expect(BInt(7) % BInt(-4) == BInt(3))
        #expect(BInt(-7) % BInt(-4) == BInt(-3))
        #expect(BInt(7) % 4 == BInt(3))
        #expect(BInt(-7) % 4 == BInt(-3))
        #expect(BInt(7) % (-4) == BInt(3))
        #expect(BInt(-7) % (-4) == BInt(-3))
        #expect(BInt(7).mod(BInt(4)) == BInt(3))
        #expect(BInt(-7).mod(BInt(4)) == BInt(1))
        #expect(BInt(7).mod(BInt(-4)) == BInt(3))
        #expect(BInt(-7).mod(BInt(-4)) == BInt(1))
        #expect(BInt(7).mod(4) == 3)
        #expect(BInt(-7).mod(4) == 1)
        #expect(BInt(7).mod(-4) == 3)
        #expect(BInt(-7).mod(-4) == 1)
        #expect(BInt(8).mod(4) == 0)
        #expect(BInt(-8).mod(4) == 0)
        #expect(BInt(8).mod(-4) == 0)
        #expect(BInt(-8).mod(-4) == 0)
        checkDivMod(BInt(7), BInt(4))
        checkDivMod(BInt(-7), BInt(4))
        checkDivMod(BInt(7), BInt(-4))
        checkDivMod(BInt(-7), BInt(-4))
        checkDivMod(BInt(Limbs(repeating: UInt64.max, count: 50)), BInt(Limbs(repeating: UInt64.max, count: 35)))
    }

    @Test func zeroDividend() {
        #expect(BInt(0) / BInt(7) == BInt.ZERO)
        #expect(-BInt(0) / BInt(7) == BInt.ZERO)
        #expect(BInt(0) / BInt(-7) == BInt.ZERO)
        #expect(-BInt(0) / BInt(-7) == BInt.ZERO)
        #expect(BInt(7) % BInt(7) == BInt.ZERO)
        #expect(BInt(-7) % BInt(7) == BInt.ZERO)
        #expect(BInt(7) % BInt(-7) == BInt.ZERO)
        #expect(BInt(-7) % BInt(-7) == BInt.ZERO)
        #expect(BInt(7) % 7 == BInt.ZERO)
        #expect(BInt(-7) % 7 == BInt.ZERO)
        #expect(BInt(7) % (-7) == BInt.ZERO)
        #expect(BInt(-7) % (-7) == BInt.ZERO)
    }

    @Test func bintModInt() {
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 1000)
            let m = x._magnitude[0] == 0 ? 1 : Int(x._magnitude[0] & 0x7fffffffffffffff)
            #expect(x.mod(m) == x.mod(BInt(m)).asInt()!)
            #expect(x.mod(-m) == x.mod(-BInt(m)).asInt()!)
        }
    }

    @Test func intDivisorConsistency() {
        let x = BInt(bitWidth: 1000)
        checkIntDivisor(x, 1)
        checkIntDivisor(x, -1)
        checkIntDivisor(x, 10)
        checkIntDivisor(x, -10)
        checkIntDivisor(x, Int.max)
        checkIntDivisor(x, Int.max - 1)
        checkIntDivisor(x, Int.min)
        checkIntDivisor(x, Int.min + 1)
    }

}
