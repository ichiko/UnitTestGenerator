//
//  SwiftCodeParser.swift
//  UnitTestGenerator
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import Foundation

class SwiftCodeParser {
    var result: [ClassDefinition] = []
    var currentClass: ClassDefinition?

    //
    // 前提
    // - きれいにフォーマットされている
    //
    func parse(source: String) -> [ClassDefinition] {
        result.removeAll()

        source.enumerateLines { (line, stop) in
            if self.isComment(line: line) {
                // no action
            } else {
                _ = self.extractClass(line: line) || self.extractFunction(line: line)
            }
        }
        if let klass = currentClass {
            result.append(klass)
        }

        return result
    }

    func isComment(line: String) -> Bool {
        let pattern = "^[ |\t]*//"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.characters.count))
        return matches.count > 0
    }

    func extractClass(line: String) -> Bool {
        if let klassName = match(line, pattern: "class ([^ :]*)[: ]") {
            if let klass = currentClass {
                result.append(klass)
            }
            currentClass = ClassDefinition(name: klassName)
            return true
        }
        return false
    }

    func extractFunction(line: String) -> Bool {
        let pattern = "func ([^ (]*)[ ]*\\((.*)\\)"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.characters.count))
        if matches.count > 0 {
            let funcName = (line as NSString).substring(with: matches[0].rangeAt(1))
            let argList = (line as NSString).substring(with: matches[0].rangeAt(2))
            let parameters = extractArguments(line: argList)
            let function = FunctionDefinition(name: funcName, parameters: parameters, hasThrows: hasThrows(line: line))
            currentClass?.add(function: function)
            return true
        }
        return false
    }

    func hasThrows(line: String) -> Bool {
        let pattern = "func.* throws"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.characters.count))
        return matches.count > 0
    }

    func extractArguments(line: String) -> [Parameter] {
        let pattern = "([^ \\:]*)[ ]*\\:[ ]*([^ ,]*),*"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.characters.count))
        if matches.count > 0 {
            var parameters = [Parameter]()
            for match in matches {
                let name = (line as NSString).substring(with: match.rangeAt(1))
                let type = (line as NSString).substring(with: match.rangeAt(2))
                parameters.append(Parameter(name: name, type: type))
            }
            return parameters
        }
        return []
    }

    func match(_ input: String, pattern: String, options: NSRegularExpression.Options = []) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return nil
        }
        let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.characters.count))
        if matches.count > 0 {
            let range = matches[0].rangeAt(1)
            return (input as NSString).substring(with: range)
        }
        return nil
    }
}
