//
//  ToByteArrayTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 05/09/2019.
//

import Testing
@testable import BigInt

@Suite struct ToByteArrayTests {

    @Test func positiveByteArrayRoundtrip() {
        for _ in 0 ..< 10000 {
            let x = BInt(bitWidth: 1000)
            let x1 = BInt(magnitude: x.asMagnitudeBytes())
            #expect(x == x1)
            let x2 = BInt(signed: x.asSignedBytes())
            #expect(x == x2)
        }
    }

    @Test func negativeByteArrayRoundtrip() {
        for _ in 0 ..< 10000 {
            let x = -BInt(bitWidth: 1000)
            let x1 = -BInt(magnitude: x.asMagnitudeBytes())
            #expect(x == x1)
            let x2 = BInt(signed: x.asSignedBytes())
            #expect(x == x2)
        }
    }

}
