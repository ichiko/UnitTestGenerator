//
//  ClassStructure.swift
//  UnitTestGenerator
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import Foundation

enum ParameterType {
    case numeric
    case string
}

struct Parameter {
    let name: String
    let type: String
}

class FunctionDefinition {
    let name: String
    var paramaters: [Parameter]
    let hasThrows: Bool

    init(name: String, parameters: [Parameter], hasThrows: Bool) {
        self.name = name
        self.hasThrows = hasThrows
        self.paramaters = parameters
    }

    func add(parameter: Parameter) {
        paramaters.append(parameter)
    }
}

class ClassDefinition {
    let name: String
    var functions: [FunctionDefinition]

    init(name: String) {
        self.name = name
        self.functions = []
    }

    func add(function: FunctionDefinition) {
        functions.append(function)
    }
}

func ==(left: Parameter, right: Parameter) -> Bool {
    return left.name == right.name && left.type == right.type
}
