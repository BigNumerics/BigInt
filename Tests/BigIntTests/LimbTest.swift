//
//  LimbTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 24/12/2018.
//

import Testing
@testable import BigInt

@Suite struct LimbTests {

    @Test func limbOperations() {
        var x1: Limbs = [0, 0, 0]
        #expect(x1.count == 3)
        x1.ensureSize(5)
        #expect(x1.count == 5)
        x1.normalize()
        #expect(x1.count == 1)
        x1 = [0, 0, 1]
        #expect(x1.bitWidth == 129)
        x1.setBitAt(1)
        #expect(BInt(x1) == (BInt(1) << 128) + 2)
    }

}
