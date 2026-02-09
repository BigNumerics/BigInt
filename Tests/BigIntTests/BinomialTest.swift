//
//  BinomialTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 26/05/2022.
//

import Testing
@testable import BigInt

@Suite struct BinomialTests {

    func checkBinomial(_ n: Int) {
        for k in 0 ... n {
            #expect(BInt.binomial(n, k) == BInt.factorial(n) / (BInt.factorial(k) * BInt.factorial(n - k)))
        }
    }

    @Test func binomialMatchesFactorial() {
        #expect(BInt.binomial(0, 0) == BInt.ONE)
        #expect(BInt.binomial(1, 0) == BInt.ONE)
        #expect(BInt.binomial(1, 1) == BInt.ONE)
        #expect(BInt.binomial(1000, 0) == BInt.ONE)
        #expect(BInt.binomial(1000, 1000) == BInt.ONE)
        for n in 0 ... 500 {
            checkBinomial(n)
        }
    }

}
