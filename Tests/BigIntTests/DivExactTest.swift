//
//  DivExactTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 04/09/2022.
//

import Testing
@testable import BigInt

@Suite struct DivExactTests {

    func checkExactDivision(_ x: BInt, _ d: BInt) {
        let q = x.quotientExact(dividingBy: d)
        if x != q * d {
            print(x)
            print(d)
        }
        #expect(x == q * d)
    }

    func checkExactDivision(_ x: BInt, _ d: Int) {
        let q = x.quotientExact(dividingBy: BInt(d))
        #expect(x == q * d)
    }

    func checkAllSigns(_ x: BInt, _ d: BInt) {
        checkExactDivision(x, d)
        checkExactDivision(x, -d)
        checkExactDivision(-x, d)
        checkExactDivision(-x, -d)
    }

    func checkAllSignsInt(_ x: BInt, _ d: Int) {
        checkExactDivision(x, d)
        checkExactDivision(x, -d)
        checkExactDivision(-x, d)
        checkExactDivision(-x, -d)
    }

    @Test func exactDivisionBInt() {
        checkAllSigns(BInt.ZERO, BInt.ONE)
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 200)
            var d = BInt.ONE
            for _ in 0 ..< 10 {
                checkAllSigns(x * d, d)
                checkAllSigns(x * d, x)
                d *= 10
            }
        }
    }

    @Test func exactDivisionInt() {
        checkAllSignsInt(BInt.ZERO, 1)
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 200)
            var d = 1
            for _ in 0 ..< 10 {
                checkAllSignsInt(x * d, d)
                d *= 10
            }
        }
    }

}
