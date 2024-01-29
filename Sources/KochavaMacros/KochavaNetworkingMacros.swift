// Kochava

/// A macro that synchronizes execution.
///
/// Example:
///
///     #let_execution_synchronize(executor: self)
///
/// Produces the following code:
///
///     let execution = self.execution
///     execution.lock()
///     defer { execution.unlock }
///
@freestanding(declaration, names: arbitrary)
public macro let_execution_synchronize(executor: AnyObject)
= #externalMacro(module: "KochavaMacrosMacros", type: "ExecutionSynchronizeMacro")
