//
//  Test.swift
//  BigInt
//
//  Created by Mike Griebling on 11.10.2024.
//

import Testing
@testable import BigInt

@Suite struct ExtensionTests {

    @Test func swiftExtensions() {
        let x = BInt(12345678901234567890123456789)
        let l = BInt(integerLiteral: 12345678901234567890123456789)
        let s = BInt("12345678901234567890123456789")
        #expect(BInt.isSigned)
        #expect(BInt(clamping: 12345) == BInt(12345))
        #expect(l == s)
        #expect(l == x)
        #expect(BInt.zero.words == [0])
        #expect(x.words == [5097733592125636885, 669260594])
        #expect(BInt(-123_890) == BInt("-123890"))
        let x1 = x << BInt(5)
        var y1 = x; y1 <<= 5
        #expect(x1 == y1)
        let x2 = x >> BInt(5)
        var y2 = x; y2 >>= 5
        #expect(x2 == y2)
        var x3 = x; x3 >>= BInt(1000)
        #expect(x3 == BInt.zero)
        #expect(BInt(exactly: 123.45) == nil)
        #expect(BInt(123.45) == BInt(123))
        #expect(BInt(exactly: 123) == BInt(123))
        #expect(BInt(truncatingIfNeeded: 1234567890) == BInt(1234567890))
        #expect(x.magnitude == x)
    }

}
