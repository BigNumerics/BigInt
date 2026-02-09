//
//  BitTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 31/12/2018.
//

import Testing
@testable import BigInt

@Suite struct BitTests {

    func checkNegation(_ x1: BInt) {
        var x2 = x1
        x2.negate()
        #expect(x1 == -x2)
        #expect(~x1 + 1 == -x1)
    }

    @Test func negateAndClearBit() {
        checkNegation(BInt(0))
        checkNegation(BInt(1))
        checkNegation(BInt(-1))
        checkNegation(BInt(bitWidth: 200))
        var x1 = BInt.ONE << 37
        x1.clearBit(37)
        #expect(x1.isZero)
        var x2 = BInt.ONE << 150
        x2.clearBit(150)
        #expect(x2.isZero)
    }

    @Test func bitwiseDistributivity() {
        let a = BInt(bitWidth: 300)
        let b = BInt(bitWidth: 300)
        let c = BInt(bitWidth: 300)
        #expect(b ^ b ^ b == b)
        #expect(a & (b | c) == (a & b) | (a & c))
    }

    @Test func flipBitInverse() {
        let a = BInt(bitWidth: 300)
        var b = a
        for i in 0 ..< 300 {
            b.flipBit(i)
        }
        for i in 0 ..< 300 {
            #expect(a.testBit(i) == !b.testBit(i))
        }
    }

    @Test func bitwiseIdentities() {
        let a = BInt(bitWidth: 300)
        #expect(a | BInt.ZERO == a)
        #expect(a & BInt.ZERO == BInt.ZERO)
        #expect(a & ~BInt.ZERO == a)
        #expect(a ^ BInt.ZERO == a)
        #expect(a ^ ~BInt.ZERO == ~a)
    }

    @Test func bitwiseSmallValues() {
        let b3 = BInt(3)
        let bm3 = BInt(-3)
        let b7 = BInt(7)
        let bm7 = BInt(-7)
        #expect(b3 & b7 == BInt(3))
        #expect(b3 & bm7 == BInt(1))
        #expect(bm3 & b7 == BInt(5))
        #expect(bm3 & bm7 == BInt(-7))
        #expect(b3 | b7 == BInt(7))
        #expect(b3 | bm7 == BInt(-5))
        #expect(bm3 | b7 == BInt(-1))
        #expect(bm3 | bm7 == BInt(-3))
        #expect(b3 ^ b7 == BInt(4))
        #expect(b3 ^ bm7 == BInt(-6))
        #expect(bm3 ^ b7 == BInt(-6))
        #expect(bm3 ^ bm7 == BInt(4))
        #expect(~b3 == BInt(-4))
        #expect(~bm3 == BInt(2))
        #expect(~b7 == BInt(-8))
        #expect(~bm7 == BInt(6))
    }

    @Test func bitwiseCommutativity() {
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 100)
            let y = BInt(bitWidth: 300)
            checkNegation(x)
            checkNegation(y)
            #expect(x & y == y & x)
            #expect(x & -y == -y & x)
            #expect(-x & y == y & -x)
            #expect(-x & -y == -y & -x)
            #expect(x | y == y | x)
            #expect(x | -y == -y | x)
            #expect(-x | y == y | -x)
            #expect(-x | -y == -y | -x)
            #expect(x ^ y == y ^ x)
            #expect(x ^ -y == -y ^ x)
            #expect(-x ^ y == y ^ -x)
            #expect(-x ^ -y == -y ^ -x)
        }
    }

    @Test func setBitClearBitFlipBit() {
        let x = BInt(bitWidth: 50)
        var y = x
        y.setBit(-1)
        #expect(x == y)
        y.clearBit(-1)
        #expect(x == y)
        y.flipBit(-1)
        #expect(x == y)
        #expect(!y.testBit(-1))
        y = BInt(0)
        y.setBit(200)
        #expect(y._magnitude.count == 4)
        #expect(y == BInt.ONE << 200)
        #expect(y.testBit(200))
        y.clearBit(200)
        #expect(y._magnitude.count == 1)
        #expect(!y.testBit(200))
        #expect(y == BInt.ZERO)
        y.flipBit(200)
        #expect(y == BInt.ONE << 200)
        y.flipBit(200)
        #expect(y == BInt.ZERO)
    }

    func popCount(_ a: BInt) -> Int {
        var n = 0
        var x = a
        while x.isNotZero {
            if x.isOdd {
                n += 1
            }
            x >>= 1
        }
        return n
    }

    @Test func populationCount() {
        #expect(BInt.ZERO.population == 0)
        let x = BInt("ffffffffffffffff", radix: 16)!
        for i in 0 ..< 100 {
            #expect((BInt.ONE << i).population == 1)
            #expect((x << i).population == 64)
        }
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 200)
            #expect(x.population == popCount(x))
        }
    }

}
