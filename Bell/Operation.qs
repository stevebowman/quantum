namespace Bell
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
            let current = M(q1);

            if (desired != current)
            {
                X(q1);
            }
        }
    }

    operation BellTest (count : Int, initial: Result) : (Int,Int)
    {
        body
        {
            mutable numOnes = 0;

            // Allocate an array of QBits for us to use.
            using (qubits = Qubit[1])
            {
                for (test in 1..count)
                {
                    // Set the initial value
                    Set (initial, qubits[0]);

                    // Create superposition - 50% zero and 50% one
                    H(qubits[0]);

                    // Measure the value of the qubit.
                    let res = M (qubits[0]);

                    // Count the number of ones we saw:
                    if (res == One)
                    {
                        set numOnes = numOnes + 1;
                    }
                }

                // Need to reset the qubit back to zero now we have finished with it.
                Set(Zero, qubits[0]);
            }
            
            // Return number of times we saw a |0> and number of times we saw a |1>
            return (count-numOnes, numOnes);
        }
    }
}
