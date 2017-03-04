//
//  CodeGeneratorTest.swift
//  UnitTestGenerator
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import XCTest

class CodeGeneratorTest: XCTestCase {

    func testGenerateNormal() {
        let klass = sampleKlassNormal()
        let generator = CodeGenerator()

        let expectedOutput = "//\n// Generated test code from \(klass.name)\n//\n\n"
            + "import XCTest\n\n"
            + "class SparrowTest: XCTestCase {\n"
            + "    func testEat() {\n\n"
            + "    }\n"
            + "}\n"

        XCTAssertEqual(generator.generateTestClass(fromClass: klass), expectedOutput)
    }

    func sampleKlassNormal() -> ClassDefinition {
        let klass = ClassDefinition(name: "Sparrow")
        klass.add(function: FunctionDefinition(name: "eat", parameters: [Parameter(name: "energy", type: "Meal")], hasThrows: false))
        return klass
    }

    func testGenerateWithIntParameter() {
        let klass = sampleKlassWithIntParameter()
        let generator = CodeGenerator()

        let expectedOutput = "//\n// Generated test code from \(klass.name)\n//\n\n"
            + "import XCTest\n\n"
            + "class SparrowTest: XCTestCase {\n"
            + "    func testFly() {\n\n"
            + "    }\n\n"
            + "    func testFlyWithMaximumValue() {\n\n"
            + "    }\n\n"
            + "    func testFlyWithValueOutOfBounds() {\n\n"
            + "    }\n"
            + "}\n"

        XCTAssertEqual(generator.generateTestClass(fromClass: klass), expectedOutput)
    }

    func sampleKlassWithIntParameter() -> ClassDefinition {
        let klass = ClassDefinition(name: "Sparrow")
        klass.add(function: FunctionDefinition(name: "fly",
                                               parameters: [Parameter(name: "to_km", type: "Int")],
                                               hasThrows: false))
        return klass
    }

    func testGenerateWithThrows() {
        let klass = sampleKlassWithThrows()
        let generator = CodeGenerator()

        let expectedOutput = "//\n// Generated test code from \(klass.name)\n//\n\n"
            + "import XCTest\n\n"
            + "class SparrowTest: XCTestCase {\n"
            + "    func testMigrate() {\n\n"
            + "    }\n\n"
            + "    func testFailMigrate() {\n\n"
            + "    }\n"
            + "}\n"

        XCTAssertEqual(generator.generateTestClass(fromClass: klass), expectedOutput)
    }

    func sampleKlassWithThrows() -> ClassDefinition {
        let klass = ClassDefinition(name: "Sparrow")
        klass.add(function: FunctionDefinition(name: "migrate",
                                               parameters: [Parameter(name: "to", type: "Habitit")],
                                               hasThrows: true))
        return klass
    }

    func testIsNumeric() {
        let generator = CodeGenerator()
        XCTAssert(generator.isNumeric("Int"))
        XCTAssert(generator.isNumeric("Double"))
        XCTAssertFalse(generator.isNumeric("String"))
    }
}
