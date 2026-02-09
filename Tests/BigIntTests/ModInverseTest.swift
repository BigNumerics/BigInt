//
//  ModInverseTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 02/01/2019.
//

import Testing
@testable import BigInt

@Suite struct ModInverseTests {

    func checkModInverse(_ n: Int, _ m: Int) {
        for _ in 0 ..< 100 {
            let p1 = BInt.probablePrime(m)
            var x1 = BInt(bitWidth: n)
            if x1 == 0 {
                x1 = BInt(1)
            }
            if x1.gcd(p1) == BInt.ONE {
                #expect((x1 * x1.modInverse(p1)).mod(p1) == BInt.ONE)
                #expect(((-x1) * (-x1).modInverse(p1)).mod(p1) == BInt.ONE)
                if let pp1 = p1.asInt() {
                    #expect(x1.modInverse(p1) == x1.modInverse(pp1))
                }
            }
            if x1.isEven {
                x1 += 1
            }
            for i in 1 ..< 12 {
                let m = BInt.ONE << i
                let q1 = x1.modInverse(m)
                let q2 = (-x1).modInverse(m)
                #expect((q1 * x1).mod(m) == BInt.ONE)
                #expect((q2 * (-x1)).mod(m) == BInt.ONE)
            }
        }
    }

    @Test func modInverseVariousBitwidths() {
        checkModInverse(3, 4)
        checkModInverse(30, 40)
        checkModInverse(300, 400)
        checkModInverse(4, 3)
        checkModInverse(40, 30)
        checkModInverse(400, 300)
    }

    @Test func modInverseEdgeCases() {
        #expect(BInt.TWO.modInverse(1) == 0)
        #expect((-BInt.TWO).modInverse(1) == 0)
        #expect(BInt.THREE.modInverse(1) == 0)
        #expect((-BInt.THREE).modInverse(1) == 0)
        #expect(BInt.TWO.modInverse(BInt.ONE) == BInt.ZERO)
        #expect((-BInt.TWO).modInverse(BInt.ONE) == BInt.ZERO)
        #expect(BInt.THREE.modInverse(BInt.ONE) == BInt.ZERO)
        #expect((-BInt.THREE).modInverse(BInt.ONE) == BInt.ZERO)
    }

    @Test func modInversePow2() {
        let x1 = BInt.ONE << 20 + 1
        let x2 = BInt.ONE << 200 + 1
        for i in 1 ... 62 {
            let m = 1 << i
            #expect(BInt(x1.modInverse(m)) == x1.modInverse(BInt(m)))
            #expect((x1 * x1.modInverse(m)).mod(m) == 1)

            #expect(BInt((-x1).modInverse(m)) == (-x1).modInverse(BInt(m)))
            #expect(((-x1) * (-x1).modInverse(m)).mod(m) == 1)

            #expect(BInt(x2.modInverse(m)) == x2.modInverse(BInt(m)))
            #expect((x2 * x2.modInverse(m)).mod(m) == 1)

            #expect(BInt((-x2).modInverse(m)) == (-x2).modInverse(BInt(m)))
            #expect(((-x2) * (-x2).modInverse(m)).mod(m) == 1)
        }
        #expect(BInt(x1.modInverse(1)) == x1.modInverse(BInt(1)))
        #expect(BInt((-x1).modInverse(1)) == (-x1).modInverse(BInt(1)))
        #expect(BInt(x2.modInverse(1)) == x2.modInverse(BInt(1)))
        #expect(BInt((-x2).modInverse(1)) == (-x2).modInverse(BInt(1)))
    }

}
