//
//  CodeGeneratorTest.swift
//  UnitTestGenerator
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import XCTest

class CodeGeneratorTest: XCTestCase {

    func testGenerate() {
        let klass = sampleKlass()
        let generator = CodeGenerator()

        let expectedOutput = "//\n// Generated test code from \(klass.name)\n//\n\n"
            + "import XCTest\n\n"
            + "class SparrowTest: XCTestCase {\n"
            + "    func testFly {\n\n"
            + "    }\n"
            + "}\n"

        XCTAssertEqual(generator.generateTestClass(fromClass: klass), expectedOutput)
    }

    func sampleKlass() -> ClassDefinition {
        let klass = ClassDefinition(name: "Sparrow")
        klass.add(function: FunctionDefinition(name: "fly", parameters: [Parameter(name: "to_km", type: "Int")], hasThrows: false))
        return klass
    }

}
