import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `let_execution_synchronize` macro.
///
///     #let_execution_synchronize(executor: self)
///
///  will expand to
///
///     let execution = self.execution
///     execution.lock()
///     defer { execution.unlock }
public struct ExecutionSynchronizeMacro: DeclarationMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> [DeclSyntax] {
        guard let executorArgument = node.argumentList.first?.expression else
        {
            fatalError("compiler bug: the macro does not have the necessary arguments")
        }

        return [
            """
            let execution = \(executorArgument).execution
            execution.lock()
            defer { execution.unlock() }
            """
        ]
    }
}

@main
struct KochavaMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ExecutionSynchronizeMacro.self,
    ]
}
