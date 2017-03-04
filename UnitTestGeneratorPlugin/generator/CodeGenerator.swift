//
//  CodeGenerator.swift
//  UnitTestGenerator
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import Foundation

class CodeGenerator {
    func generateTestClass(fromClass klass: ClassDefinition) -> String {
        var output = ""
        output += generateHeader(ofClass: klass)
        output += generateOpenClass(ofClass: klass)
        for function in klass.functions {
            output += generateOpenFunction(ofFunction: function)
            output += "\n"
            output += generateCloseFunction()
        }
        output += generateCloseClass()
        return output
    }

    func generateHeader(ofClass klass: ClassDefinition) -> String {
        return "//\n// Generated test code from \(klass.name)\n//\n\n"
            + "import XCTest\n\n"
    }

    func generateOpenClass(ofClass klass: ClassDefinition) -> String {
        return "class \(klass.name)Test: XCTestCase {\n"
    }

    func generateCloseClass() -> String {
        return "}\n"
    }

    func generateOpenFunction(ofFunction function: FunctionDefinition) -> String {
        let name = function.name
        let start = name.startIndex
        let end = name.index(start, offsetBy: 1)
        let capitalizedName = function.name.replacingCharacters(in: Range(uncheckedBounds: (lower: start, upper: end)),
                                                                with: function.name.substring(to: end).capitalized)

        var output = "    "
        output += "func test\(capitalizedName) {\n"
        return output
    }

    func generateCloseFunction() -> String {
        return "    }\n"
    }
}
