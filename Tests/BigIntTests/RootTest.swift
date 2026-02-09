import Testing
@testable import BigInt

@Suite struct RootTests {

    @Test func nthRoot() {
        for _ in 0 ..< 100 {
            let x = BInt(bitWidth: 20000)
            for n in 1 ... 10 {
                let y = x.root(n)
                #expect((y ** n) <= x)
                #expect(((y + 1) ** n) > x)
                let (root, rem) = x.rootRemainder(n)
                #expect((root ** n) + rem == x)
            }
            let x1 = -x
            for n in stride(from: 1, through: 11, by: 2) {
                let y = x1.root(n)
                #expect((y ** n) >= x1)
                #expect(((y - 1) ** n) < x1)
                let (root, rem) = x1.rootRemainder(n)
                #expect((root ** n) + rem == x1)
            }
        }
    }

    @Test func sqrtMod() {
        for _ in 0 ..< 100 {
            let p100 = BInt.probablePrime(100)
            for _ in 0 ..< 100 {
                let x = BInt(bitWidth: 300)
                let s = x.sqrtMod(p100)
                let j = x.jacobiSymbol(p100)
                #expect(j == 1 || s == nil)
                #expect(j != 1 || (s! ** 2).mod(p100) == x.mod(p100))
            }
            let p60 = BInt.probablePrime(60)
            let p = p60.asInt()!
            for _ in 0 ..< 100 {
                let x = BInt(bitWidth: 300)
                let s60 = x.sqrtMod(p60)
                let s = x.sqrtMod(p)
                if s == nil {
                    #expect(s60 == nil)
                } else {
                    #expect(s60 != nil)
                    #expect(s60! == BInt(s!) || s60! == p60 - BInt(s!))
                }
            }
        }
    }

    @Test func sqrt() {
        var bw = 2
        for _ in 0 ..< 20 {
            for _ in 0 ..< 10 {
                let x = BInt(bitWidth: bw)
                #expect((x ** 2).sqrt() == x)
                let s = x.sqrt()
                #expect((s ** 2) <= x)
                #expect(((s + 1) ** 2) > x)
                let (root, rem) = x.sqrtRemainder()
                #expect((root ** 2) + rem == x)
            }
            bw *= 2
        }
    }

    @Test func isPerfectSquare() {
        #expect(BInt.ZERO.isPerfectSquare())
        #expect(BInt.ONE.isPerfectSquare())
        #expect(!(-BInt.ONE).isPerfectSquare())
        for i in 2 ..< 1000 {
            let x = BInt(i)
            let x1 = x + 1
            let x2 = x - 1
            #expect((x * x).isPerfectSquare())
            #expect(!(x * x1).isPerfectSquare())
            #expect(!(x * x2).isPerfectSquare())
        }
    }

    @Test func sqrtRemainder() {
        for i in 0 ..< 1000 {
            let x = BInt(i)
            let (root, rem) = x.sqrtRemainder()
            #expect(root * root + rem == x)
            #expect(x.isPerfectSquare() || rem.isPositive)
            #expect(!x.isPerfectSquare() || rem.isZero)
        }
    }

    @Test func isPerfectRoot() {
        #expect(BInt.ZERO.isPerfectRoot())
        #expect(BInt.ONE.isPerfectRoot())
        #expect((-BInt.ONE).isPerfectRoot())
        for i in 0 ..< 1000 {
            let x = BInt(i)
            let perfect = x.isPerfectRoot()
            for n in 2 ... 10 {
                #expect((x ** n).isPerfectRoot())
                let (_, rem) = x.rootRemainder(n)
                #expect(perfect || rem.isPositive)
            }
            let x1 = -x
            for n in stride(from: 1, through: 11, by: 2) {
                let y = x1.root(n)
                #expect((y ** n) >= x1)
                #expect(((y - 1) ** n) < x1)
                let (root, rem) = x1.rootRemainder(n)
                #expect((root ** n) + rem == x1)
            }
        }
    }

}
