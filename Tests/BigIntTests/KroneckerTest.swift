//
//  KroneckerTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 09/06/2022.
//

import Testing
@testable import BigInt

@Suite struct KroneckerTests {

    func checkKroneckerBInt(_ a: BInt, _ b: BInt, _ c: BInt, _ d: BInt) {
        let abcd = (a * b).kroneckerSymbol(c * d)
        let acd = a.kroneckerSymbol(c * d)
        let bcd = b.kroneckerSymbol(c * d)
        let abc = (a * b).kroneckerSymbol(c)
        let abd = (a * b).kroneckerSymbol(d)
        let ac = a.kroneckerSymbol(c)
        let bc = b.kroneckerSymbol(c)
        let ad = a.kroneckerSymbol(d)
        let bd = b.kroneckerSymbol(d)
        #expect(abcd == acd * bcd)
        #expect(abcd == abc * abd)
        #expect(abcd == ac * bc * ad * bd)
    }

    func checkKroneckerInt(_ a: BInt, _ b: BInt, _ c: Int, _ d: Int) {
        let abcd = (a * b).kroneckerSymbol(c * d)
        let acd = a.kroneckerSymbol(c * d)
        let bcd = b.kroneckerSymbol(c * d)
        let abc = (a * b).kroneckerSymbol(c)
        let abd = (a * b).kroneckerSymbol(d)
        let ac = a.kroneckerSymbol(c)
        let bc = b.kroneckerSymbol(c)
        let ad = a.kroneckerSymbol(d)
        let bd = b.kroneckerSymbol(d)
        #expect(abcd == acd * bcd)
        #expect(abcd == abc * abd)
        #expect(abcd == ac * bc * ad * bd)
    }

    func checkKronecker(_ a: Int, _ b: Int, _ c: Int, _ d: Int) {
        checkKroneckerBInt(BInt(a), BInt(b), BInt(c), BInt(d))
        checkKroneckerInt(BInt(a), BInt(b), c, d)
    }

    @Test func kroneckerKnownValues() {
        #expect(BInt.ZERO.kroneckerSymbol(BInt.ZERO) == 0)
        #expect(BInt.ONE.kroneckerSymbol(BInt.ZERO) == 1)
        #expect((-BInt.ONE).kroneckerSymbol(BInt.ZERO) == 1)
        for n in 1 ... 100 {
            #expect(BInt(n).kroneckerSymbol(BInt.ONE) == 1)
            #expect(BInt(-n).kroneckerSymbol(BInt.ONE) == 1)
        }
        for k in 1 ... 100 {
            #expect(BInt.ONE.kroneckerSymbol(k) == 1)
            #expect(BInt.ONE.kroneckerSymbol(-k) == 1)
        }
    }

    @Test func kroneckerRandomValues() {
        let b1000 = BInt(1000)
        for _ in 0 ..< 100 {
            let a = b1000.randomLessThan().asInt()!
            let b = b1000.randomLessThan().asInt()!
            let c = b1000.randomLessThan().asInt()!
            let d = b1000.randomLessThan().asInt()!
            checkKronecker(a, b, c, d)
        }
    }

}
