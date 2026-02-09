//
//  FractionTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 28/06/2022.
//

import Testing
@testable import BigInt

@Suite struct FractionTests {

    func checkInit(_ n: Int, _ d: Int) {
        #expect(BFraction(n, d) == BFraction(BInt(n), BInt(d)))
        #expect(BFraction(n, d) == BFraction(n, BInt(d)))
        #expect(BFraction(n, d) == BFraction(BInt(n), d))
    }

    @Test func initialization() {
        checkInit(0, 1)
        checkInit(1, 1)
        checkInit(-1, 1)
        checkInit(0, -1)
        checkInit(1, -1)
        checkInit(-1, -1)
        checkInit(Int.max, Int.max)
        checkInit(Int.max, Int.min)
        checkInit(Int.min, Int.max)
        checkInit(Int.min, Int.min)
        for _ in 0 ..< 10 {
            let n = BInt(bitWidth: 100)
            let d = BInt(bitWidth: 100) + 1
            let f1 = BFraction(n, d)
            #expect(f1.numerator.gcd(f1.denominator) == BInt.ONE)
            #expect(f1.denominator.isPositive)
            let f2 = BFraction(0, d)
            #expect(f2.numerator == BInt.ZERO)
            #expect(f2.denominator == BInt.ONE)
        }
        for _ in 0 ..< 10 {
            let d = Double.random(in: -100.0 ... 100.0)
            let f = BFraction(d)!
            #expect(f.numerator.gcd(f.denominator) == BInt.ONE)
            #expect(f.denominator.isPositive)
            #expect(f.abs <= 100)
        }
        #expect(BFraction(0.0 / 0.0) == nil)
        #expect(BFraction(1.0 / 0.0) == nil)
        #expect(BFraction(0.1)! == BFraction(
            BInt("1000000000000000055511151231257827021181583404541015625")!, BInt(10) ** 55))
        #expect(BFraction(0.1)! == BFraction(3602879701896397, 36028797018963968))
        #expect(BFraction(0.0)!.isZero)
        #expect(BFraction(-0.0)!.isZero)
    }

    @Test func comparison() {
        for _ in 0 ..< 10 {
            let n = BInt(bitWidth: 100)
            let d = BInt(bitWidth: 100)
            let g = n.gcd(d)
            let f = BFraction(n, d)
            let x = BFraction(0.1)!
            #expect(f == BFraction(n / g, d / g))
            #expect(f < f + x)
            #expect(f > f - x)
        }
        #expect(BFraction(1, 10) < BFraction(0.1)!)
    }

    @Test func rounding() {
        #expect(BFraction.ZERO.round() == 0)
        #expect(BFraction.ZERO.truncate() == 0)
        #expect(BFraction.ZERO.ceil() == 0)
        #expect(BFraction.ZERO.floor() == 0)
        #expect(BFraction.ONE.round() == 1)
        #expect(BFraction.ONE.truncate() == 1)
        #expect(BFraction.ONE.ceil() == 1)
        #expect(BFraction.ONE.floor() == 1)
        #expect(BFraction(-1, 1).round() == -1)
        #expect(BFraction(-1, 1).truncate() == -1)
        #expect(BFraction(-1, 1).ceil() == -1)
        #expect(BFraction(-1, 1).floor() == -1)
        for _ in 0 ..< 1000 {
            let n = BInt(bitWidth: 100)
            let d = BInt(bitWidth: 100) + 1
            let f1 = BFraction(n, d)
            let f2 = -f1
            let round1 = f1.round()
            let round2 = f2.round()
            let trunc1 = f1.truncate()
            let trunc2 = f2.truncate()
            let ceil1 = f1.ceil()
            let ceil2 = f2.ceil()
            let floor1 = f1.floor()
            let floor2 = f2.floor()
            #expect(round1 == ceil1 || round1 == floor1)
            #expect(round2 == ceil2 || round2 == floor2)
            #expect(trunc1 == floor1)
            #expect(trunc2 == ceil2)
            #expect(ceil1 >= round1)
            #expect(ceil1 >= trunc1)
            #expect(ceil1 >= floor1)
            #expect(floor1 <= round1)
            #expect(floor1 <= trunc1)
            #expect(floor1 <= ceil1)
            #expect((round1 - f1).abs < 1)
            #expect((round2 - f2).abs < 1)
            #expect((trunc1 - f1).abs < 1)
            #expect((trunc2 - f2).abs < 1)
            #expect((ceil1 - f1).abs < 1)
            #expect((ceil2 - f2).abs < 1)
            #expect((floor1 - f1).abs < 1)
            #expect((floor2 - f2).abs < 1)
        }
    }

    @Test func arithmetic() {
        for _ in 0 ..< 1000 {
            let na = BInt(bitWidth: 200)
            let da = BInt(bitWidth: 200) + 1
            let nb = BInt(bitWidth: 200)
            let db = BInt(bitWidth: 200) + 1
            let nc = BInt(bitWidth: 100)
            let dc = BInt(bitWidth: 100) + 1
            let fa = BFraction(na, da)
            let fb = BFraction(nb, db)
            let fc = BFraction(nc, dc)
            #expect((fa + fb) * fc == fa * fc + fb * fc)
            #expect((fa - fb) * fc == fa * fc - fb * fc)
            #expect((fa + fb) / fc == fa / fc + fb / fc)
            #expect((fa - fb) / fc == fa / fc - fb / fc)
        }
    }

    @Test func exponentiation() {
        let a = BFraction(BInt(bitWidth: 100), BInt(bitWidth: 100) + 1)
        var x1 = a ** 10
        var x2 = BFraction(1, 1)
        for _ in 0 ..< 10 {
            x2 *= a
        }
        #expect(x1 == x2)
        x1 = ((-a) ** 10)
        x2 = BFraction(1, 1)
        for _ in 0 ..< 10 {
            x2 *= (-a)
        }
        #expect(x1 == x2)
    }

    func checkIntOperation(_ f: BFraction, _ x: Int) {
        let fx = BFraction(x, 1)
        let X = BInt(x)
        #expect(f + fx == f + x)
        #expect(f + fx == x + f)
        #expect(f + fx == f + X)
        #expect(f + fx == X + f)
        #expect(f - fx == f - x)
        #expect(f - fx == f - X)
        #expect(f * fx == f * x)
        #expect(f * fx == x * f)
        #expect(f * fx == f * X)
        #expect(f * fx == X * f)
        if x != 0 {
            #expect(f / fx == f / x)
            #expect(f / fx == f / X)
        }
        let eq = f == fx
        let ne = f != fx
        let lt = f < fx
        let gt = f > fx
        let le = f <= fx
        let ge = f >= fx
        #expect(eq == (f == x))
        #expect(eq == (f == X))
        #expect(eq == (x == f))
        #expect(eq == (X == f))
        #expect(ne == (f != x))
        #expect(ne == (f != X))
        #expect(ne == (x != f))
        #expect(ne == (X != f))
        #expect(lt == (f < x))
        #expect(lt == (f < X))
        #expect(lt == (x > f))
        #expect(lt == (X > f))
        #expect(gt == (f > x))
        #expect(gt == (f > X))
        #expect(gt == (x < f))
        #expect(gt == (X < f))
        #expect(le == (f <= x))
        #expect(le == (f <= X))
        #expect(le == (x >= f))
        #expect(le == (X >= f))
        #expect(ge == (f >= x))
        #expect(ge == (f >= X))
        #expect(ge == (x <= f))
        #expect(ge == (X <= f))
    }

    func checkIntOperations(_ f: BFraction) {
        checkIntOperation(f, 0)
        checkIntOperation(f, 1)
        checkIntOperation(f, -1)
        checkIntOperation(f, Int.max)
        checkIntOperation(f, Int.min)
    }

    @Test func intOperations() {
        checkIntOperations(BFraction.ZERO)
        checkIntOperations(BFraction.ONE)
        checkIntOperations(-BFraction.ONE)
        checkIntOperations(BFraction(Int.max, 1))
        checkIntOperations(BFraction(Int.min, 1))
    }

    @Test func conversion() {
        let f1 = BFraction(1, 10)
        let f2 = BFraction(0.1)!
        #expect(f1.asDecimalString(precision: 1) == "0.1")
        #expect(f1.asDecimalString(precision: 55) == "0.1000000000000000000000000000000000000000000000000000000")
        #expect(f2.asDecimalString(precision: 1) == "0.1")
        #expect(f2.asDecimalString(precision: 55) == "0.1000000000000000055511151231257827021181583404541015625")
    }

    struct testB {

        let n: Int
        let num: BInt
        let denum: Int

        init(_ n: Int, _ num: BInt, _ denum: Int) {
            self.n = n
            self.num = num
            self.denum = denum
        }
    }

    let tests: [testB] = [
        testB(0, BInt("1")!, 1),
        testB(1, BInt("1")!, 2),
        testB(2, BInt("1")!, 6),
        testB(4, BInt("-1")!, 30),
        testB(6, BInt("1")!, 42),
        testB(8, BInt("-1")!, 30),
        testB(10, BInt("5")!, 66),
        testB(12, BInt("-691")!, 2730),
        testB(14, BInt("7")!, 6),
        testB(16, BInt("-3617")!, 510),
        testB(18, BInt("43867")!, 798),
        testB(20, BInt("-174611")!, 330),
        testB(22, BInt("854513")!, 138),
        testB(24, BInt("-236364091")!, 2730),
        testB(26, BInt("8553103")!, 6),
        testB(28, BInt("-23749461029")!, 870),
        testB(30, BInt("8615841276005")!, 14322),
        testB(32, BInt("-7709321041217")!, 510),
        testB(34, BInt("2577687858367")!, 6),
        testB(36, BInt("-26315271553053477373")!, 1919190),
        testB(38, BInt("2929993913841559")!, 6),
        testB(40, BInt("-261082718496449122051")!, 13530),
        testB(42, BInt("1520097643918070802691")!, 1806),
        testB(44, BInt("-27833269579301024235023")!, 690),
        testB(46, BInt("596451111593912163277961")!, 282),
        testB(48, BInt("-5609403368997817686249127547")!, 46410),
        testB(50, BInt("495057205241079648212477525")!, 66),
        testB(52, BInt("-801165718135489957347924991853")!, 1590),
        testB(54, BInt("29149963634884862421418123812691")!, 798),
        testB(56, BInt("-2479392929313226753685415739663229")!, 870),
        testB(58, BInt("84483613348880041862046775994036021")!, 354),
        testB(60, BInt("-1215233140483755572040304994079820246041491")!, 56786730),
    ]

    @Test func decimalString() {
        for _ in 0 ..< 100 {
            let n = BInt(bitWidth: 1000)
            let d = BInt(bitWidth: 100) + 1
            let x = BFraction(n, d)
            let s1 = x.asDecimalString(precision: 100, exponential: false)
            let s2 = x.asDecimalString(precision: 100, exponential: true)
            #expect(BFraction(s1)! == BFraction(s2)!)
        }
    }

    @Test func bernoulliNumbers() {
        for t in tests {
            let b = BFraction.bernoulli(t.n)
            #expect(b == BFraction(t.num, t.denum))
        }
        for i in 1 ..< 100 {
            #expect(BFraction.bernoulli(2 * i + 1) == BFraction.ZERO)
        }
    }

    @Test func bernoulliSequence() {
        let x = BFraction.bernoulliSequence(200)
        for i in 0 ..< 200 {
            #expect(BFraction.bernoulli(2 * i) == x[i])
        }
    }

    func checkMod(_ f: BFraction, _ P: BInt) {
        let p = P.asInt()!
        let M = f.mod(P)
        let m = f.mod(p)
        if M == nil {
            #expect(m == nil)
            #expect(f.denominator.gcd(P) > 1)
        } else {
            let MI = f.denominator.modInverse(P)
            #expect(M! == (MI * f.numerator).mod(P))
            #expect(M! == BInt(m!))
        }
    }

    @Test func modulus() {
        for _ in 0 ..< 1000 {
            let P = BInt(bitWidth: 50)
            let f = BFraction(BInt(bitWidth: 200), BInt(bitWidth: 100) + 1)
            checkMod(f, P)
            checkMod(-f, P)
            checkMod(f, BInt.ONE)
            checkMod(-f, BInt.ONE)
            checkMod(BFraction.ONE, P)
            checkMod(-BFraction.ONE, P)
        }
    }

    @Test func continuedFractionsBInt() {
        let f = BFraction([BInt.ZERO])
        #expect(f == BFraction.ZERO)
        #expect(f.asContinuedFraction() == [BInt.ZERO])
        for _ in 0 ..< 10 {
            var x = [BInt](repeating: BInt.ZERO, count: 100)
            for i in 0 ..< x.count {
                x[i] = BInt(1000).randomLessThan() + 1
            }
            let f = BFraction(x)
            let y = f.asContinuedFraction()
            #expect(x == y || x[x.count - 1] == BInt.ONE)
            #expect(x != y || x[x.count - 1] != BInt.ONE)
            x[0] = -x[0]
            let g = BFraction(x)
            let z = g.asContinuedFraction()
            #expect(x == z || x[x.count - 1] == BInt.ONE)
            #expect(x != z || x[x.count - 1] != BInt.ONE)
        }
    }

    func B2I(_ b: [BInt]) -> [Int] {
        var x = [Int](repeating: 0, count: b.count)
        for i in 0 ..< x.count {
            x[i] = b[i].asInt()!
        }
        return x
    }

    @Test func continuedFractionsInt() {
        let f = BFraction([0])
        #expect(f == BFraction.ZERO)
        #expect(f.asContinuedFraction() == [BInt.ZERO])
        for _ in 0 ..< 10 {
            var x = [Int](repeating: 0, count: 100)
            for i in 0 ..< x.count {
                x[i] = (BInt(1000).randomLessThan() + 1).asInt()!
            }
            let f = BFraction(x)
            let y = f.asContinuedFraction()
            #expect(x == B2I(y) || x[x.count - 1] == BInt.ONE)
            #expect(x != B2I(y) || x[x.count - 1] != BInt.ONE)
            x[0] = -x[0]
            let g = BFraction(x)
            let z = g.asContinuedFraction()
            #expect(x == B2I(z) || x[x.count - 1] == BInt.ONE)
            #expect(x != B2I(z) || x[x.count - 1] != BInt.ONE)
        }
    }

    @Test func equalityOperator() {
        let x = BFraction(35, 7)
        #expect(x == BInt(5))
        #expect(BInt(5) == x)
        #expect(x == 5)
        #expect(5 == x)
        #expect(-x == BInt(-5))
        #expect(BInt(-5) == -x)
        #expect(-x == -5)
        #expect(-5 == -x)
    }

    @Test func inequalityOperator() {
        let x = BFraction(35, 7)
        #expect(x != BInt(6))
        #expect(BInt(6) != x)
        #expect(x != 6)
        #expect(6 != x)
        #expect(-x != BInt(-6))
        #expect(BInt(-6) != -x)
        #expect(-x != -6)
        #expect(-6 != -x)
    }

    @Test func lessThanOperator() {
        let x = BFraction(35, 7)
        #expect(x < BInt(6))
        #expect(BInt(4) < x)
        #expect(x < 6)
        #expect(4 < x)
        #expect(BInt(-6) < -x)
        #expect(-x < BInt(-4))
        #expect(-6 < -x)
        #expect(-x < -4)
    }

    @Test func greaterThanOperator() {
        let x = BFraction(35, 7)
        #expect(x > BInt(4))
        #expect(BInt(6) > x)
        #expect(x > 4)
        #expect(6 > x)
        #expect(-x > BInt(-6))
        #expect(BInt(-4) > -x)
        #expect(-x > -6)
        #expect(-4 > -x)
    }

    @Test func lessOrEqualOperator() {
        let x = BFraction(35, 7)
        #expect(x <= BInt(6))
        #expect(x <= BInt(5))
        #expect(x <= 6)
        #expect(x <= 5)
        #expect(BInt(-6) <= -x)
        #expect(BInt(-5) <= -x)
        #expect(-6 <= -x)
        #expect(-5 <= -x)
    }

    @Test func greaterOrEqualOperator() {
        let x = BFraction(35, 7)
        #expect(x >= BInt(4))
        #expect(x >= BInt(5))
        #expect(x >= 4)
        #expect(x >= 5)
        #expect(BInt(-4) >= -x)
        #expect(BInt(-5) >= -x)
        #expect(-4 >= -x)
        #expect(-5 >= -x)
    }

    @Test func harmonicNumbers() {
        let n = 100
        let harmonics = BFraction.harmonicSequence(n)
        for i in 0 ..< n {
            #expect(harmonics[i] == BFraction.harmonic(i + 1))
        }
    }
}
