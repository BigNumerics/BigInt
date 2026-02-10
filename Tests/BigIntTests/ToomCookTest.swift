//
//  ToomCookTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 09/02/2019.
//

import Testing
@testable import BigInt

@Suite struct ToomCookTests {

    @Test func toomCookMultiplication() {
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: Limbs.TC_THR * 5 * 64)
            let b = BInt(bitWidth: Limbs.TC_THR * 2 * 64)
            let p = a * b
            #expect(p == b * a)
            let (q, r) = p.quotientAndRemainder(dividingBy: a)
            #expect(q == b)
            #expect(r == BInt.ZERO)
        }
    }

    @Test func toomCookSquaring() {
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: Limbs.TC_THR * 10 * 64)
            let p = a ** 2
            let (q, r) = p.quotientAndRemainder(dividingBy: a)
            #expect(q == a)
            #expect(r == BInt.ZERO)
        }
    }

    @Test func toomCookEdgeCases() {
        let b1 = BInt([0xffffffffffffffff]) << (Limbs.TC_THR * 64)
        let b2 = BInt([0x8000000000000000]) << (Limbs.TC_THR * 64)
        #expect(b1 * b1 == (b1 ** 2))
        #expect(b2 * b2 == (b2 ** 2))
        let x = b1 * b2
        #expect(x == b2 * b1)
        let (q1, r1) = x.quotientAndRemainder(dividingBy: b1)
        #expect(q1 == b2)
        #expect(r1 == BInt.ZERO)
        let (q2, r2) = x.quotientAndRemainder(dividingBy: b2)
        #expect(q2 == b1)
        #expect(r2 == BInt.ZERO)
    }

    @Test func toomCookVsKaratsuba() {
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: (Limbs.TC_THR + 1) * 64)
            let b = BInt(bitWidth: (Limbs.TC_THR + 1) * 64)
            let p = a * b
            let pK = BInt(a._magnitude.karatsubaTimes(b._magnitude))
            #expect(p == pK)
        }
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: (Limbs.TC_THR + 1) * 64)
            let p = a ** 2
            let pK = BInt(a._magnitude.karatsubaSquare())
            #expect(p == pK)
        }
    }

}
