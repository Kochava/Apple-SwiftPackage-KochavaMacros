import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(KochavaMacrosMacros)
import KochavaMacrosMacros

let testMacros: [String: Macro.Type] = [
    "let_execution_synchronize": ExecutionSynchronizeMacro.self,
]
#endif

final class KochavaMacrosTests: XCTestCase {
    func testMacro() throws {
        #if canImport(KochavaMacrosMacros)
        assertMacroExpansion(
            """
            #let_execution_synchronize(a + b)
            """,
            expandedSource: """
            (a + b, "a + b")
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testMacroWithStringLiteral() throws {
        #if canImport(KochavaMacrosMacros)
        assertMacroExpansion(
            #"""
            #let_execution_synchronize("Hello, \(name)")
            """#,
            expandedSource: #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
