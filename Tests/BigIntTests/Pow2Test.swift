//
//  AdditionTest.swift
//  BigIntTests
//
//  Created by Leif Ibsen on 17/01/2019.
//

import Testing
@testable import BigInt

@Suite struct Pow2Tests {

    @Test func isPow2() {
        #expect((BInt.ONE << 0).isPow2)
        #expect((BInt.ONE << 1).isPow2)
        #expect((BInt.ONE << 5).isPow2)
        #expect((BInt.ONE << 100).isPow2)
        #expect((BInt.ONE << 1000).isPow2)
        #expect(!(-BInt.ONE << 0).isPow2)
        #expect(!(-BInt.ONE << 1).isPow2)
        #expect(!(-BInt.ONE << 5).isPow2)
        #expect(!(-BInt.ONE << 100).isPow2)
        #expect(!(-BInt.ONE << 1000).isPow2)
        #expect(!((BInt.ONE << 1 + 1).isPow2))
        #expect(!((BInt.ONE << 5 + 1).isPow2))
        #expect(!((BInt.ONE << 100 + 1).isPow2))
        #expect(!((BInt.ONE << 1000 + 1).isPow2))
    }

}
