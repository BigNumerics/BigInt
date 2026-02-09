//
//  JacobiTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 24/01/2021.
//

import Testing
@testable import BigInt

@Suite struct JacobiTests {

    func checkJacobiBInt(_ a: Int, _ b: Int, _ m: Int, _ n: Int) {
        let am = BInt(a).jacobiSymbol(m)
        let bm = BInt(b).jacobiSymbol(m)
        let an = BInt(a).jacobiSymbol(n)
        let abm = (BInt(a) * b).jacobiSymbol(m)
        let amn = BInt(a).jacobiSymbol(m * n)
        #expect(abm == am * bm)
        #expect(amn == am * an)
    }

    func checkJacobiInt(_ a: Int, _ b: Int, _ m: BInt, _ n: BInt) {
        let am = BInt(a).jacobiSymbol(m)
        let bm = BInt(b).jacobiSymbol(m)
        let an = BInt(a).jacobiSymbol(n)
        let abm = (BInt(a) * b).jacobiSymbol(m)
        let amn = BInt(a).jacobiSymbol(m * n)
        #expect(abm == am * bm)
        #expect(amn == am * an)
    }

    func checkJacobi(_ a: Int, _ b: Int, _ m: Int, _ n: Int) {
        checkJacobiBInt(a, b, m, n)
        checkJacobiInt(a, b, BInt(m), BInt(n))
    }

    @Test func jacobiKnownValues() {
        checkJacobi(0, 0, 5, 11)
        checkJacobi(3, 4, 5, 11)
        checkJacobi(0, 0, 33, 11)
        checkJacobi(3, 4, 33, 11)
    }

    @Test func jacobiRandomValues() {
        let b1000 = BInt(1000)
        for _ in 0 ..< 100 {
            let a = b1000.randomLessThan().asInt()!
            let b = b1000.randomLessThan().asInt()!
            var m = b1000.randomLessThan().asInt()!
            if m & 1 == 0 {
                m += 1
            }
            var n = b1000.randomLessThan().asInt()!
            if n & 1 == 0 {
                n += 1
            }
            checkJacobi(a, b, m, n)
            checkJacobi(-a, b, m, n)
            checkJacobi(a, -b, m, n)
            checkJacobi(-a, -b, m, n)
        }
    }
}
