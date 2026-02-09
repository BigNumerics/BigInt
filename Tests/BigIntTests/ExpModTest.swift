//
//  ExpModTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 04/02/2019.
//

import Testing
@testable import BigInt

@Suite struct ExpModTests {

    let a1 = BInt("43271512091896741409394736939900206368860872098952555939")!
    let x1 = BInt("42267688843543983783885633938053687583065584419295560555")!
    let m1 = BInt("65559338391610243479024015552681806795487318988418855174")!
    let mp1 = BInt("14708028296754883426561209612579760556999800024666797837")!

    let a2 = BInt("9879959622001881798420480569351120749752891168795071469741009590796905186183625061410538508653929799901162907503196502223071902180994253404412067954774342232969326053454779870840130810532326017165678692636647404921424922403748460111140358572478743271512091896741409394736939900206368860872098952555939")!
    let x2 = BInt("4149842346989426807721754542711895351513161856205879655378968612408032038996656528445703209766166328006052965811745650295935314936056815509075542554308409615827636639641110901357012471113482422183741588797481891328204616583065067700486989814417842267688843543983783885633938053687583065584419295560555")!
    let m2 = BInt("10524302966485349118258764179820205386685991992586369700154893101599927732040662774460446149003080427232451962311367600902738242964142492968383265627950930467854069828393051189273332522792516344807937835132537814794042705435787095095919023768140765559338391610243479024015552681806795487318988418855174")!
    let mp2 = BInt("1122200972247120546333043544356752277213829455746835691791369400547247327000588079094470008395425401827849174141816902264513461023891163414270218627387835660351885298195540293936217720560009323739879363833688454142584347044964970051959361123182603999640496505409063560777205949747764493609693376510835")!

    let a3 = BInt("2988348162058574136915891421498819466320163312926952423791023078876139")!
    let x3 = BInt("2351399303373464486466122544523690094744975233415544072992656881240319")!
    let m3 = BInt("10000000000000000000000000000000000000000")!
    let mp3 = BInt("1527229998585248450016808958343740453059")!

    @Test func basicExpMod() {
        #expect(BInt(3).expMod(BInt(7), BInt(1)) == BInt(0))
        #expect(BInt(2).expMod(BInt(10), BInt(1000)) == BInt(24))
    }

    @Test func knownValues() {
        #expect(a1.expMod(x1, m1) == mp1)
        #expect(a1.expMod(-x1, m1) == mp1.modInverse(m1))
        #expect((-a1).expMod(x1, m1) == m1 - mp1)
        #expect((-a1).expMod(-x1, m1) == (m1 - mp1).modInverse(m1))
        #expect(a2.expMod(x2, m2) == mp2)
        #expect(a2.expMod(-x2, m2) == mp2.modInverse(m2))
        #expect((-a2).expMod(x2, m2) == m2 - mp2)
        #expect((-a2).expMod(-x2, m2) == (m2 - mp2).modInverse(m2))
        #expect(a3.expMod(x3, m3) == mp3)
        #expect(a3.expMod(-x3, m3) == mp3.modInverse(m3))
        #expect((-a3).expMod(x3, m3) == m3 - mp3)
        #expect((-a3).expMod(-x3, m3) == (m3 - mp3).modInverse(m3))
    }

    @Test func edgeCases() {
        #expect(BInt(-2).expMod(BInt(0), BInt(11)) == BInt(1))
        #expect(BInt(2).expMod(BInt(0), BInt(11)) == BInt(1))
        #expect(BInt(1).expMod(BInt(2), BInt(11)) == BInt(1))
        #expect(BInt(1).expMod(BInt(-2), BInt(11)) == BInt(1))
        #expect(BInt(-2).expMod(BInt(-3), BInt(11)) == BInt(4))
        #expect(BInt(-11).expMod(BInt(2), BInt(11)) == BInt(0))
        #expect(BInt(2).expMod(BInt(5), BInt(11)) == BInt(10))
        #expect(BInt(2).expMod(BInt(-5), BInt(11)) == BInt(10))
        #expect(BInt(2).expMod(BInt(4), BInt(11)) == BInt(5))
        #expect(BInt(2).expMod(BInt(-4), BInt(11)) == BInt(9))
        #expect(BInt(-2).expMod(BInt(5), BInt(11)) == BInt(1))
        #expect(BInt(-2).expMod(BInt(-5), BInt(11)) == BInt(1))
        #expect(BInt(-2).expMod(BInt(4), BInt(11)) == BInt(5))
        #expect(BInt(-2).expMod(BInt(-4), BInt(11)) == BInt(9))
        #expect(BInt(0).expMod(BInt(5), BInt(11)) == BInt(0))
        #expect(BInt(0).expMod(BInt(4), BInt(11)) == BInt(0))
    }

    @Test func chineseRemainderTheorem() {
        checkCRT(BInt.ONE, BInt.ONE, BInt.ONE)
        checkCRT(BInt.ONE, BInt.ONE, BInt.ONE << 1)
        checkCRT(a1, x1, m1)
        checkCRT(a2, x2, m2)
        checkCRT(a3, x3, m3)
        checkCRT(a3, x3, m3 << 200)
        checkCRT(a3, x3, BInt.ONE << 200)
        checkCRT(a1, BInt.ONE << 5000, m1)
        checkCRT(a1, BInt.ONE << 5000, m1 + 1)
        checkCRT(a3, x3, BInt.ONE)
    }

    func checkCRT(_ a: BInt, _ x: BInt, _ m: BInt) {
        let r1 = a.expMod(x, m)

        let trailing = m.trailingZeroBitCount
        let pow2Modulus = BInt.ONE << trailing
        let oddModulus = m >> trailing
        let a1 = a.expMod(x, oddModulus)
        let a2 = a.expMod(x, pow2Modulus)
        let y1 = pow2Modulus.modInverse(oddModulus)
        let y2 = oddModulus.modInverse(pow2Modulus)
        let r2 = (a1 * pow2Modulus * y1 + a2 * oddModulus * y2).mod(m)

        #expect(r1 == r2)
    }

    @Test func barrettVsMontgomery() {
        checkBarrettMontgomery(a1, x1, mp1)
        checkBarrettMontgomery(a2, x2, mp2)
        checkBarrettMontgomery(a3, x3, mp3)
    }

    func checkBarrettMontgomery(_ a: BInt, _ x: BInt, _ m: BInt) {
        #expect(computeBasicExpMod(a, x, m) == BInt.BarrettModulus(a, m).expMod(x))
    }

    func computeBasicExpMod(_ a: BInt, _ x: BInt, _ m: BInt) -> BInt {
        var result = BInt.ONE
        var base = a % m
        var exp = x
        while exp.isPositive {
            if exp.isOdd {
                result = (result * base) % m
            }
            exp >>= 1
            base = (base ** 2) % m
        }
        return result
    }

    @Test func intModulusConsistency() {
        checkIntModulus(a1, x1, 1)
        checkIntModulus(a1, x1, 2)
        checkIntModulus(a1, x1, Int.max)
        for _ in 0 ..< 1000 {
            let m = Int.random(in: 1 ..< Int.max)
            checkIntModulus(a1, x1, m)
        }
    }

    func checkIntModulus(_ a: BInt, _ x: BInt, _ m: Int) {
        let x1 = a.expMod(x, m)
        let x2 = a.expMod(x, BInt(m))
        #expect(BInt(x1) == x2)
        let x3 = (-a).expMod(x, m)
        let x4 = (-a).expMod(x, BInt(m))
        #expect(BInt(x3) == x4)
        if x2.gcd(BInt(m)) == 1 {
            let x5 = a.expMod(-x, m)
            let x6 = a.expMod(-x, BInt(m))
            #expect(BInt(x5) == x6)
            let x7 = (-a).expMod(-x, m)
            let x8 = (-a).expMod(-x, BInt(m))
            #expect(BInt(x7) == x8)
        }
    }

    @Test func pow2ModulusBugfix() {
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 63) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 63))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 64) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 64))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 65) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 65))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 127) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 127))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 128) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 128))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 129) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 129))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 191) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 191))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 192) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 192))
        #expect(a1.expMod(BInt.ONE, BInt.ONE << 193) == computeBasicExpMod(a1, BInt.ONE, BInt.ONE << 193))
    }
}
