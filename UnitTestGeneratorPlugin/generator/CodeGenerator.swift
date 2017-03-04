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
            output += generateVariation(ofFunction: function)
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

    // TODO: 2つ以上の引数の考慮
    func generateVariation(ofFunction function: FunctionDefinition) -> String {
        var output = ""
        if function.paramaters.count == 0 {
            output += generateOpenFunction(ofFunction: function)
            output += generateBody(ofFunction: function)
            output += generateCloseFunction()
        } else {
            var suffixVariation = [String]()
            var prefixVariation = [String]()
            if function.hasThrows {
                prefixVariation.append("Fail")
            }
            // NOTE: パラメータのひとつめだけ見る
            let parameter = function.paramaters[0]
            if isNumeric(parameter.type) {
                suffixVariation.append("MaximumValue")
                suffixVariation.append("ValueOutOfBounds")
            } else if isString(parameter.type) {
                suffixVariation.append("TooLongString")
            }

            // basic pattern
            output += generateOpenFunction(ofFunction: function)
            output += generateBody(ofFunction: function)
            output += generateCloseFunction()

            // success or fail pattern
            for prefix in prefixVariation {
                if output.characters.count > 0 {
                    output += "\n"
                }
                output += generateOpenFunction(ofFunction: function, prefix: prefix)
                output += generateBody(ofFunction: function)
                output += generateCloseFunction()
            }

            // input variation pattern
            for suffix in suffixVariation {
                if output.characters.count > 0 {
                    output += "\n"
                }
                output += generateOpenFunction(ofFunction: function, prefix: "", suffix: suffix)
                output += generateBody(ofFunction: function)
                output += generateCloseFunction()
            }
        }
        return output
    }

    func isNumeric(_ type: String) -> Bool {
        return ["Int", "Float", "Double", "Number"].index(of: type) != nil
    }

    func isString(_ type: String) -> Bool {
        return type == "String"
    }

    func generateOpenFunction(ofFunction function: FunctionDefinition, prefix: String = "", suffix: String = "") -> String {
        let name = function.name
        let start = name.startIndex
        let end = name.index(start, offsetBy: 1)
        let capitalizedName = function.name.replacingCharacters(in: Range(uncheckedBounds: (lower: start, upper: end)),
                                                                with: function.name.substring(to: end).capitalized)

        var output = "    "
        if suffix.isEmpty {
            output += "func test\(prefix)\(capitalizedName)() {\n"
        } else {
            output += "func test\(prefix)\(capitalizedName)With\(suffix)() {\n"
        }
        return output
    }

    func generateBody(ofFunction function: FunctionDefinition) -> String {
        return "\n"
    }

    func generateCloseFunction() -> String {
        return "    }\n"
    }
}
