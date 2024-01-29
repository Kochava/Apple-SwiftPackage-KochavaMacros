import KochavaMacros

class KVAExecution
{
    func lock() { }
    func unlock() { }
}

class Example
{
    let execution = KVAExecution()
    
    func evaluate()
    {
        #let_execution_synchronize(executor: self)
        
        print("doing something")
    }
}


