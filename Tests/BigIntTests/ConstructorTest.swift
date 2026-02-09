//
//  ConstructorTest.swift
//  XBigIntegerTests
//
//  Created by Leif Ibsen on 11/12/2018.
//

import Testing
@testable import BigInt

@Suite struct ConstructorTests {

    @Test func basicConstructors() {
        let x1 = BInt("123", radix: 10)!
        #expect(x1._magnitude.count == 1)
        #expect(!(x1.isNegative))
        let x2 = BInt("-0", radix: 10)!
        #expect(x2._magnitude.count == 1)
        #expect(!(x2.isNegative))
        let b: Bytes = [0, 0, 0, 123]
        let x3 = BInt(signed: b)
        #expect(x1 == x3)
        let x4 = BInt(magnitude: b)
        #expect(x1 == x4)
        let x5 = BInt(bitWidth: 100)
        #expect(x5.bitWidth <= 100)
        let x6 = BInt("-123")!
        #expect(x6._magnitude[0] == 123)
        let x71 = BInt(bitWidth: 100)
        let x72 = BInt(signed: x71.asSignedBytes())
        #expect(x71 == x72)
        let x8 = BInt.ONE << 317
        #expect(x8.trailingZeroBitCount == 317)
        let x9 = BInt(1)
        #expect(!x9.isEven)
        #expect(x9.isOdd)
        #expect(x9.isPositive)
        #expect(!x9.isNegative)
        #expect(!x9.isZero)
        #expect(x9.isNotZero)
        let x10 = BInt(-1)
        #expect(!x10.isEven)
        #expect(x10.isOdd)
        #expect(!x10.isPositive)
        #expect(x10.isNegative)
        #expect(!x10.isZero)
        #expect(x10.isNotZero)
        let x11 = BInt(0)
        #expect(x11.isEven)
        #expect(!x11.isOdd)
        #expect(!x11.isPositive)
        #expect(!x11.isNegative)
        #expect(x11.isZero)
        #expect(!x11.isNotZero)
        let x12 = BInt(bitWidth: 1)
        #expect(x12 == BInt.ONE || x12 == BInt.ZERO)
        let x13 = BInt("12345670", radix: 8)
        #expect(x13 == BInt("2739128"))
        let x14 = BInt("12345678", radix: 8)
        #expect(x14 == nil)
    }

    @Test func signAndMagnitude() {
        let x0 = BInt(0)
        let x1 = BInt(1)
        let xm1 = BInt(-1)
        #expect(x0._magnitude.count == 1)
        #expect(x1._magnitude.count == 1)
        #expect(xm1._magnitude.count == 1)
        #expect(!x0.isNegative)
        #expect(!x1.isNegative)
        #expect(xm1.isNegative)
        #expect(x0.isZero)
        #expect(x1.isPositive)
        #expect(xm1.isNegative)
    }

    @Test func signedBytes() {
        let x0 = BInt([0x8000000000000000], true)
        #expect(x0.asInt() == Int.min)
        let x1 = BInt(signed: [0])
        #expect(x1 == BInt.ZERO)
        let x2 = BInt(signed: [0, 255])
        #expect(x2 == BInt(255))
        let x3 = BInt(signed: [255])
        #expect(x3 == BInt(-1))
        let x4 = BInt(signed: [255, 0])
        #expect(x4 == BInt(-256))
        let x5 = BInt(signed: [255, 255])
        #expect(x5 == BInt(-1))
    }

    @Test func magnitudeBytes() {
        let x1 = BInt(magnitude: [0])
        #expect(x1 == BInt.ZERO)
        let x2 = BInt(magnitude: [0, 255])
        #expect(x2 == BInt(255))
        let x3 = BInt(magnitude: [255])
        #expect(x3 == BInt(255))
        let x4 = BInt(magnitude: [255, 0])
        #expect(x4 == BInt(65280))
        let x5 = BInt(magnitude: [255, 255])
        #expect(x5 == BInt(65535))
        let x6 = BInt(magnitude: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff])
        #expect(x6 == BInt("fffffffffffffffffffffffffffffffeffffffffffffffff", radix: 16)!)
        let x7 = BInt(signed: [0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff])
        #expect(x7 == BInt("fffffffffffffffffffffffffffffffeffffffffffffffff", radix: 16)!)
    }

    func checkRadixRoundtrip(_ n: Int) {
        let x = BInt(bitWidth: n)
        for r in 2 ... 36 {
            let s = x.asString(radix: r)
            #expect(x == BInt(s, radix: r))
            #expect(x == BInt("+" + s, radix: r))
            #expect(-x == BInt("-" + s, radix: r))
        }
    }

    @Test func radixStringRoundtrip() {
        checkRadixRoundtrip(1)
        checkRadixRoundtrip(10)
        checkRadixRoundtrip(100)
        checkRadixRoundtrip(1000)
        #expect(BInt("") == nil)
        #expect(BInt("+") == nil)
        #expect(BInt("-") == nil)
        #expect(BInt("+ 1") == nil)
        #expect(BInt("- 1") == nil)
    }

    @Test func doubleConversion() {
        #expect(BInt.ZERO.asDouble() == 0.0)
        #expect((-BInt.ZERO).asDouble() == 0.0)
        #expect(BInt.ONE.asDouble() == 1.0)
        #expect((-BInt.ONE).asDouble() == -1.0)
        #expect((BInt.ONE << 1024).asDouble() == Double.infinity)
        #expect(-(BInt.ONE << 1024).asDouble() == -Double.infinity)
        #expect((BInt.ONE << 1023).asDouble().isFinite)
        #expect((-(BInt.ONE << 1023)).asDouble().isFinite)
    }

    @Test func doubleInitializer() {
        #expect(BInt(0.0) == BInt.ZERO)
        #expect(BInt(1.0) == BInt.ONE)
        #expect(BInt(-1.0) == -BInt.ONE)
        #expect(BInt(0.0 / 0.0) == nil)
        #expect(BInt(1.0 / 0.0) == nil)
        #expect(BInt(-1.0 / 0.0) == nil)
        for i in 0 ..< 10 {
            #expect(BInt(10) == BInt(10.0 + Double(i) / 10.0))
            #expect(BInt(9) == BInt(10.0 - Double(i + 1) / 10.0))
            #expect(BInt(-9) == BInt(-10.0 + Double(i + 1) / 10.0))
            #expect(BInt(-10) == BInt(-10.0 - Double(i) / 10.0))
        }
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 1000)
            let d = x.asDouble()
            let x1 = BInt(d)!
            #expect((x - x1).abs.asDouble() / d <= 1.0e-15)
        }
    }

    let strings = ["0",
                   "10",
                   "120",
                   "1230",
                   "12340",
                   "123450",
                   "1234560",
                   "12345670",
                   "123456780",
                   "1234567890",
                   "123456789a0",
                   "123456789ab0",
                   "123456789abc0",
                   "123456789abcd0",
                   "123456789abcde0",
                   "123456789abcdef0",
                   "123456789abcdefg0",
                   "123456789abcdefgh0",
                   "123456789abcdefghi0",
                   "123456789abcdefghij0",
                   "123456789abcdefghijk0",
                   "123456789abcdefghijkl0",
                   "123456789abcdefghijklm0",
                   "123456789abcdefghijklmn0",
                   "123456789abcdefghijklmno0",
                   "123456789abcdefghijklmnop0",
                   "123456789abcdefghijklmnopq0",
                   "123456789abcdefghijklmnopqr0",
                   "123456789abcdefghijklmnopqrs0",
                   "123456789abcdefghijklmnopqrst0",
                   "123456789abcdefghijklmnopqrstu0",
                   "123456789abcdefghijklmnopqrstuv0",
                   "123456789abcdefghijklmnopqrstuvw0",
                   "123456789abcdefghijklmnopqrstuvwx0",
                   "123456789abcdefghijklmnopqrstuvwxy0",
                   "123456789abcdefghijklmnopqrstuvwxyz0",
    ]

    @Test func radixParsing() {
        for r in 2 ... 36 {
            for i in 0 ..< strings.count {
                let x = BInt(strings[i], radix: r)
                let X = BInt(strings[i].uppercased(), radix: r)
                if i < r {
                    #expect(x != nil)
                    let z = x?.asString(radix: r, uppercase: false)
                    #expect(z == strings[i])
                    #expect(X != nil)
                    let Z = X?.asString(radix: r, uppercase: true)
                    #expect(Z == strings[i].uppercased())
                    #expect(BInt(z!, radix: r) == BInt(Z!, radix: r))
                } else {
                    #expect(x == nil)
                    #expect(X == nil)
                }
            }
        }
    }

}
