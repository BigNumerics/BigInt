//
//  FFTTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 09/11/2021.
//

import Testing
@testable import BigInt

@Suite struct FFTTests {

    @Test func fftMultiplication() {
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: Limbs.FFT_THR * 2 * 64)
            let b = BInt(bitWidth: Limbs.FFT_THR * 2 * 64)
            let p = a * b
            #expect(p == b * a)
            let (q, r) = p.quotientAndRemainder(dividingBy: a)
            #expect(q == b)
            #expect(r == BInt.ZERO)
        }
    }

    @Test func fftSquaring() {
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: Limbs.FFT_THR * 2 * 64)
            let p = a ** 2
            let (q, r) = p.quotientAndRemainder(dividingBy: a)
            #expect(q == a)
            #expect(r == BInt.ZERO)
        }
    }

    @Test func fftEdgeCases() {
        let b1 = BInt([0xffffffffffffffff]) << (Limbs.FFT_THR * 64)
        let b2 = BInt([0x8000000000000000]) << (Limbs.FFT_THR * 64)
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

    @Test func fftVsToomCook() {
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: (Limbs.FFT_THR + 1) * 64)
            let b = BInt(bitWidth: (Limbs.FFT_THR + 1) * 64)
            let p = a * b
            let pTC = BInt(a._magnitude.toomCookTimes(b._magnitude))
            #expect(p == pTC)
        }
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: (Limbs.FFT_THR + 1) * 64)
            let p = a ** 2
            let pTC = BInt(a._magnitude.toomCookSquare())
            #expect(p == pTC)
        }
    }

    @Test func fftChainedDivision() {
        var prod = BInt.ONE
        var x = [BInt](repeating: BInt.ZERO, count: 10)
        for i in 0 ..< 10 {
            x[i] = BInt(bitWidth: (Limbs.FFT_THR + 1) * 64)
            prod *= x[i]
        }
        var q = prod
        var r = BInt.ZERO
        for i in 0 ..< 10 {
            (q, r) = q.quotientAndRemainder(dividingBy: x[i])
            #expect(r == BInt.ZERO)
        }
        #expect(q == BInt.ONE)
    }

}
