//
//  SourceEditorCommand.swift
//  UnitTestGeneratorPlugin
//
//  Created by ichiko-moro on 2017/03/04.
//  Copyright © 2017年 ichiko-moro. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        // Ref.) https://ez-net.jp/article/83/1AuGcndM/YL1DSTNKXeYD/
        // ソースコードの編集が可能なバッファー元。
        let textBuffer = invocation.buffer
        // ソースコードの各行を格納してあるNSMutableArray。各要素は Any型。
        let lines = textBuffer.lines
        print(lines)
        
        // TODO: エラー時はErrorを渡す。
//        let selections = textBuffer.selections
//        guard (selections.firstObject as? XCSourceTextRange) != nil else {
//            completionHandler(NSError(domain: "SampleExtension", code: 401, userInfo: ["reason": "text not selected"]))
//            return
//        }
        
        // TOOD: 各行をParseして、XCTestCaseファイル（既に存在している前提）にテストメソッドを新規作成できるようにする
        let parser = SwiftCodeParser()
        let result = parser.parse(source: textBuffer.completeBuffer)
        
        let generator = CodeGenerator()
        let parsedResult = generator.generateTestClass(fromClass: result[0])
        self.runCopyCommand(result: parsedResult)

        // 処理が完了時or何もしなかった時はHandlerにnilを渡す。
        completionHandler(nil)
    }
    
    // UNIXコマンドでパース結果をクリップボードにコピーする
    func runCopyCommand(result: String) {
        let pipe = Pipe()
        var task = Process()
        task.launchPath = "/bin/echo"
        task.standardOutput = pipe
        task.arguments = [result]
        task.launch()
        task.waitUntilExit()
        
        task = Process()
        task.launchPath = "/usr/bin/pbcopy"
        task.arguments = ["-c", String(format:"%@", self)]
        task.standardInput = pipe
        task.launch()
        task.waitUntilExit()
    }
}
