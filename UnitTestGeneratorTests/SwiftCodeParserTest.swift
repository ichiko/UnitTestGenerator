//
//  SwiftCodeParserTest.swift
//  UnitTestGenerator
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import XCTest

class SwiftCodeParserTest: XCTestCase {

    func testPrase() {
        let source = "//\n//  Sparrow.swift\n//  TestTargetApp\n//\n//  Created by ichiko-moro on 2017/03/04.\n//  Copyright © 2017年 ichiko-moro. All rights reserved.\n//\n\nimport Foundation\n\nenum Meal {\n    case insect\n    case meat\n}\n\nclass Sparrow {\n    func fly(to_km: Int) {\n    }\n\n    func eat(energy: Meal) -> Bool {\n        // return true if enable eat\n        return true\n    }\n\n    func migrate(to: Habitat) -> Bool {\n        // return true if enable migrate to\n        return true\n    }\n}\n"

        let parser = SwiftCodeParser()
        let result = parser.parse(source: source)
        XCTAssertEqual(result.count, 1)
    }

    func testIsComment() {
        let input = "// comment"
        let parser = SwiftCodeParser()
        XCTAssert(parser.isComment(line: input))
    }

    func testIsIndentedComment() {
        let input = "    // comment"
        let parser = SwiftCodeParser()
        XCTAssert(parser.isComment(line: input))
    }

    func testIsNotComment() {
        let input = "#not comment"
        let parser = SwiftCodeParser()
        XCTAssertFalse(parser.isComment(line: input))
    }

    func testExtractClass() {
        let input = "class SwiftCodeParserTest: XCTestCase {"
        let parser = SwiftCodeParser()
        XCTAssert(parser.extractClass(line: input))
    }

    func testExtractFunction() {
        let input = "func extractFunction(line: String) -> Bool"
        let parser = SwiftCodeParser()
        XCTAssert(parser.extractFunction(line: input))
    }

    func testExtractParameter() {
        let input = "line: String"
        let parser = SwiftCodeParser()
        let result = parser.extractArguments(line: input)
        XCTAssertEqual(result.count, 1)
        XCTAssert(result[0] == Parameter(name: "line", type: "String"))
    }

    func testExtractMultipleParameters() {
        let input = "line: String, number: Int"
        let parser = SwiftCodeParser()
        let result = parser.extractArguments(line: input)
        XCTAssertEqual(result.count, 2)
        XCTAssert(result[0] == Parameter(name: "line", type: "String"))
        XCTAssert(result[1] == Parameter(name: "number", type: "Int"))
    }
}
