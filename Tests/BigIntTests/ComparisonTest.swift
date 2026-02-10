//
//  ComparisonTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 25/08/2022.
//

import Testing
@testable import BigInt

@Suite struct ComparisonTests {

    func checkBIntComparison(_ a: BInt, _ b: BInt) {
        let eq = a == b
        let ne = a != b
        let lt = a < b
        let le = a <= b
        let gt = a > b
        let ge = a >= b
        #expect(eq != ne)
        #expect(lt != (eq || gt))
        #expect(gt != (eq || lt))
        #expect(le == (eq || lt))
        #expect(ge == (eq || gt))
    }

    func checkBIntIntComparison(_ a: BInt, _ b: Int) {
        let eq = a == b
        let ne = a != b
        let lt = a < b
        let le = a <= b
        let gt = a > b
        let ge = a >= b
        #expect(eq != ne)
        #expect(lt != (eq || gt))
        #expect(gt != (eq || lt))
        #expect(le == (eq || lt))
        #expect(ge == (eq || gt))
    }

    func checkIntBIntComparison(_ a: Int, _ b: BInt) {
        let eq = a == b
        let ne = a != b
        let lt = a < b
        let le = a <= b
        let gt = a > b
        let ge = a >= b
        #expect(eq != ne)
        #expect(lt != (eq || gt))
        #expect(gt != (eq || lt))
        #expect(le == (eq || lt))
        #expect(ge == (eq || gt))
    }

    @Test func bintComparisons() {
        checkBIntComparison(BInt.ZERO, BInt.ZERO)
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: 100)
            let b = BInt(bitWidth: 100)
            checkBIntComparison(a, a)
            checkBIntComparison(a, -a)
            checkBIntComparison(-a, a)
            checkBIntComparison(-a, -a)
            checkBIntComparison(a, b)
            checkBIntComparison(a, -b)
            checkBIntComparison(-a, b)
            checkBIntComparison(-a, -b)
        }
    }

    @Test func bintIntComparisons() {
        checkBIntIntComparison(BInt.ZERO, 0)
        for _ in 0 ..< 10 {
            let a = BInt(bitWidth: 50)
            checkBIntIntComparison(a, 0)
            checkBIntIntComparison(a, 1)
            checkBIntIntComparison(a, -1)
            checkBIntIntComparison(a, Int.max)
            checkBIntIntComparison(a, Int.min)
            checkBIntIntComparison(-a, 0)
            checkBIntIntComparison(-a, 1)
            checkBIntIntComparison(-a, -1)
            checkBIntIntComparison(-a, Int.max)
            checkBIntIntComparison(-a, Int.min)
        }
    }

    @Test func intBintComparisons() {
        checkIntBIntComparison(0, BInt.ZERO)
        for _ in 0 ..< 10 {
            let b = BInt(bitWidth: 50)
            checkIntBIntComparison(0, b)
            checkIntBIntComparison(1, b)
            checkIntBIntComparison(-1, b)
            checkIntBIntComparison(Int.max, b)
            checkIntBIntComparison(Int.min, b)
            checkIntBIntComparison(0, -b)
            checkIntBIntComparison(1, -b)
            checkIntBIntComparison(-1, -b)
            checkIntBIntComparison(Int.max, -b)
            checkIntBIntComparison(Int.min, -b)
        }
    }

    func checkEqual(_ a: BInt, _ b: BInt) {
        let ia = a.asInt()!
        let ib = b.asInt()!
        #expect((a == b) == (ia == b))
        #expect((a == b) == (a == ib))
        #expect((a == -b) == (ia == -b))
        #expect((a == -b) == (a == -ib))
        #expect((-a == b) == (-ia == b))
        #expect((-a == b) == (-a == ib))
        #expect((-a == -b) == (-ia == -b))
        #expect((-a == -b) == (-a == -ib))
    }

    func checkNotEqual(_ a: BInt, _ b: BInt) {
        let ia = a.asInt()!
        let ib = b.asInt()!
        #expect((a != b) == (ia != b))
        #expect((a != b) == (a != ib))
        #expect((a != -b) == (ia != -b))
        #expect((a != -b) == (a != -ib))
        #expect((-a != b) == (-ia != b))
        #expect((-a != b) == (-a != ib))
        #expect((-a != -b) == (-ia != -b))
        #expect((-a != -b) == (-a != -ib))
    }

    func checkLessThan(_ a: BInt, _ b: BInt) {
        let ia = a.asInt()!
        let ib = b.asInt()!
        #expect((a < b) == (ia < b))
        #expect((a < b) == (a < ib))
        #expect((a < -b) == (ia < -b))
        #expect((a < -b) == (a < -ib))
        #expect((-a < b) == (-ia < b))
        #expect((-a < b) == (-a < ib))
        #expect((-a < -b) == (-ia < -b))
        #expect((-a < -b) == (-a < -ib))
    }

    func checkLessOrEqual(_ a: BInt, _ b: BInt) {
        let ia = a.asInt()!
        let ib = b.asInt()!
        #expect((a <= b) == (ia <= b))
        #expect((a <= b) == (a <= ib))
        #expect((a <= -b) == (ia <= -b))
        #expect((a <= -b) == (a <= -ib))
        #expect((-a <= b) == (-ia <= b))
        #expect((-a <= b) == (-a <= ib))
        #expect((-a <= -b) == (-ia <= -b))
        #expect((-a <= -b) == (-a <= -ib))
    }

    func checkGreaterThan(_ a: BInt, _ b: BInt) {
        let ia = a.asInt()!
        let ib = b.asInt()!
        #expect((a > b) == (ia > b))
        #expect((a > b) == (a > ib))
        #expect((a > -b) == (ia > -b))
        #expect((a > -b) == (a > -ib))
        #expect((-a > b) == (-ia > b))
        #expect((-a > b) == (-a > ib))
        #expect((-a > -b) == (-ia > -b))
        #expect((-a > -b) == (-a > -ib))
    }

    func checkGreaterOrEqual(_ a: BInt, _ b: BInt) {
        let ia = a.asInt()!
        let ib = b.asInt()!
        #expect((a >= b) == (ia >= b))
        #expect((a >= b) == (a >= ib))
        #expect((a >= -b) == (ia >= -b))
        #expect((a >= -b) == (a >= -ib))
        #expect((-a >= b) == (-ia >= b))
        #expect((-a >= b) == (-a >= ib))
        #expect((-a >= -b) == (-ia >= -b))
        #expect((-a >= -b) == (-a >= -ib))
    }

    @Test func mixedTypeComparisons() {
        for _ in 0 ..< 100 {
            let a = BInt(bitWidth: 50)
            let b = BInt(bitWidth: 50)
            checkEqual(a, b)
            checkNotEqual(a, b)
            checkLessThan(a, b)
            checkLessOrEqual(a, b)
            checkGreaterThan(a, b)
            checkGreaterOrEqual(a, b)
        }
    }

}
