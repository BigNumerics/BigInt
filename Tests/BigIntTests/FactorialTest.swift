//
//  FactorialTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 19/05/2022.
//

import Testing
@testable import BigInt

@Suite struct FactorialTests {

    func simpleFac(_ n: Int) -> BInt {
        precondition(n > 0)
        var x = BInt.ONE
        for i in 1 ... n {
            x *= i
        }
        return x
    }

    @Test func factorialMatchesNaive() {
        #expect(BInt.factorial(0) == BInt.ONE)
        for i in 1 ... 1000 {
            #expect(BInt.factorial(i) == simpleFac(i))
        }
    }

}
