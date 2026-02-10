//
//  ShiftTest.swift
//  XBigIntegerTests
//
//  Created by Leif Ibsen on 11/12/2018.
//

import Testing
@testable import BigInt

@Suite struct ShiftTests {

    @Test func shiftLeftRight() {
        let x1 = BInt(bitWidth: 200)
        #expect(x1 == (x1 << 3) >> 3)
        #expect(x1 << -3 == x1 >> 3)
        #expect(x1 << 3 == x1 >> -3)
        #expect(x1 == (x1 << 300) >> 300)
        #expect(x1 << -300 == x1 >> 300)
        #expect(x1 << 300 == x1 >> -300)
        let x2 = BInt("1234567890")!
        #expect(x2 == (x2 << 200) / (BInt.ONE << 200))
        var x3 = x2
        x3 <<= 1
        #expect(x3 == BInt("2469135780")!)
    }

    @Test func shiftZero() {
        let x: Limbs = [0]
        #expect(x.shiftedLeft(0) == [0])
        #expect(x.shiftedLeft(1) == [0])
        #expect(x.shiftedLeft(64) == [0])
        #expect(x.shiftedLeft(65) == [0])
        #expect(x.shiftedLeft(128) == [0])
        #expect(x.shiftedLeft(129) == [0])
    }

    @Test func shiftIntMinMax() {
        #expect(BInt.ZERO << Int.max == BInt.ZERO)
        #expect(BInt.ZERO >> Int.max == BInt.ZERO)
        #expect(BInt.ONE >> Int.max == BInt.ZERO)
        #expect(BInt.ZERO << Int.min == BInt.ZERO)
        #expect(BInt.ZERO >> Int.min == BInt.ZERO)
        #expect(BInt.ONE << Int.min == BInt.ZERO)
    }

}
