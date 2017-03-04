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
        
        completionHandler(nil)
    }
    
}
