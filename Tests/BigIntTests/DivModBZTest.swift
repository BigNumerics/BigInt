//
//  DivModBZTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 05/12/2021.
//

import Testing
@testable import BigInt

@Suite struct DivModBZTests {

    let b1 = BInt("1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", radix: 16)!
    let b2 = BInt("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", radix: 16)!

    func checkBZDivMod(_ dividend: BInt, _ divisor: BInt) {
        var q1: Limbs = []
        var r1: Limbs = []
        var q2: Limbs = []
        var r2: Limbs = []
        (q1, r1) = dividend._magnitude.divMod(divisor._magnitude)
        (q2, r2) = dividend._magnitude.bzDivMod(divisor._magnitude)
        #expect(q1 == q2)
        #expect(r1 == r2)
    }

    func checkQuotientRemainder(_ dividend: BInt, _ divisor: BInt) {
        let (q, r) = dividend.quotientAndRemainder(dividingBy: divisor)
        #expect(dividend == divisor * q + r)
    }

    @Test func burnikelZieglerBasic() {
        for _ in 0 ..< 1000 {
            let x = BInt(bitWidth: 2 * (Limbs.BZ_DIV_LIMIT + 1) * 64)
            let y = BInt(bitWidth: (Limbs.BZ_DIV_LIMIT + 1) * 64)
            checkBZDivMod(x, y)
            checkQuotientRemainder(x, y)
            checkQuotientRemainder(x, -y)
            checkQuotientRemainder(-x, y)
            checkQuotientRemainder(-x, -y)
        }
        checkBZDivMod(BInt(Limbs(repeating: UInt64.max, count: 2 * (Limbs.BZ_DIV_LIMIT + 1))), BInt(Limbs(repeating: UInt64.max, count: Limbs.BZ_DIV_LIMIT + 1)))
    }

    @Test func burnikelZieglerScaled() {
        var n = 2
        for _ in 0 ..< 8 {
            let y1 = BInt.ONE << ((Limbs.BZ_DIV_LIMIT + 1) * 64 * n)
            let y2 = BInt(bitWidth: (Limbs.BZ_DIV_LIMIT + 1) * 64 * n)
            n *= 2
            let x1 = BInt.ONE << ((Limbs.BZ_DIV_LIMIT + 1) * 64 * n)
            let x2 = BInt(bitWidth: (Limbs.BZ_DIV_LIMIT + 1) * 64 * n)
            checkBZDivMod(x1, y1)
            checkBZDivMod(x1, y2)
            checkBZDivMod(x2, y1)
            checkBZDivMod(x2, y2)
        }
    }

    @Test func regressionTest() {
        checkQuotientRemainder(b1 * b1, b1)
        checkQuotientRemainder(b2 * b2, b2)
    }

}
