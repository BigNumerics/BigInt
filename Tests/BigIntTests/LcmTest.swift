//
//  LcmTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 13/02/2022.
//

import Testing
@testable import BigInt

@Suite struct LcmTests {

    @Test func lcmBInt() {
        #expect(BInt.ZERO.lcm(BInt.ZERO) == BInt.ZERO)
        #expect(BInt.ZERO.lcm(BInt.ONE) == BInt.ZERO)
        #expect(BInt.ONE.lcm(BInt.ZERO) == BInt.ZERO)
        #expect(BInt(18).lcm(BInt(21)) == BInt(126))
        #expect(BInt(-18).lcm(BInt(21)) == BInt(126))
        #expect(BInt(18).lcm(BInt(-21)) == BInt(126))
        #expect(BInt(-18).lcm(BInt(-21)) == BInt(126))
    }

    @Test func lcmInt() {
        #expect(BInt.ZERO.lcm(0) == BInt.ZERO)
        #expect(BInt.ZERO.lcm(1) == BInt.ZERO)
        #expect(BInt.ONE.lcm(0) == BInt.ZERO)
        #expect(BInt(18).lcm(21) == BInt(126))
        #expect(BInt(-18).lcm(21) == BInt(126))
        #expect(BInt(18).lcm(-21) == BInt(126))
        #expect(BInt(-18).lcm(-21) == BInt(126))
    }

}
