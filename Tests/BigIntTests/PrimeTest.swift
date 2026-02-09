import Testing
@testable import BigInt

@Suite
struct PrimeTests {
    func checkMersenne(_ x: Int) {
        #expect((BInt(1) << x - 1).isProbablyPrime())
        #expect(!(BInt(1) << x + 1).isProbablyPrime())
    }

    @Test func probablePrime() {
        #expect(!BInt(100).isProbablyPrime())
        #expect(!BInt(100).isProbablyPrime(1))
        for i in 1 ... 5 {
            #expect(BInt.probablePrime(100 * i).isProbablyPrime())
        }
    }

    @Test func mersennePrimes() {
        checkMersenne(3)
        checkMersenne(5)
        checkMersenne(7)
        checkMersenne(13)
        checkMersenne(17)
        checkMersenne(19)
        checkMersenne(31)
        checkMersenne(61)
        checkMersenne(89)
        checkMersenne(107)
        checkMersenne(127)
        checkMersenne(521)
    }

    @Test func nextPrimeSequential() {
        #expect(BInt(-14).nextPrime() == BInt.TWO)
        var x = BInt.ZERO
        for _ in 0 ..< 1000 {
            let p = x.nextPrime()
            #expect(p.isProbablyPrime(100))
            var z = x + 1
            while z < p {
                #expect(!z.isProbablyPrime(100))
                z += 1
            }
            x = p
        }
    }

    @Test func nextPrimeFromRandomBase() {
        for _ in 0 ..< 10 {
            let x = BInt(bitWidth: 100)
            let p = x.nextPrime()
            #expect(p.isProbablyPrime(100))
            var z = x + 1
            while z < p {
                #expect(!z.isProbablyPrime(100))
                z += 1
            }
        }
    }

    @Test func primorial() {
        #expect(BInt.primorial(0) == BInt(1))
        #expect(BInt.primorial(1) == BInt(1))
        #expect(BInt.primorial(2) == BInt(2))
        #expect(BInt.primorial(3) == BInt(6))
        #expect(BInt.primorial(4) == BInt(6))
        #expect(BInt.primorial(5) == BInt(30))
        #expect(BInt.primorial(6) == BInt(30))
        #expect(BInt.primorial(7) == BInt(210))
        #expect(BInt.primorial(8) == BInt(210))
        #expect(BInt.primorial(9) == BInt(210))
        #expect(BInt.primorial(10) == BInt(210))
        #expect(BInt.primorial(11) == BInt(2310))
    }
}
