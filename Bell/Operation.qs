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

    operation BellTest (count : Int, initial: Result) : (Int,Int,Int)
    {
        body
        {
            mutable numOnes = 0;
            mutable agree = 0;

            // Allocate an array of QBits for us to use.
            using (qubits = Qubit[2])
            {
                for (test in 1..count)
                {
                    // Set the initial values
                    Set (initial, qubits[0]);
                    Set (Zero, qubits[1]);

                    // Create superposition - 50% zero and 50% one
                    H(qubits[0]);

                    // Create entanglement.
                    // This CNOT gate means that Q1 must always end up with the same value as Q0
                    CNOT(qubits[0],qubits[1]);

                    // Measure the value of the qubit.
                    let res = M (qubits[0]);

                    // Test if the entanglement has worked. The 2 quibits should be the same
                    // whatever the value of the Q0 has collapsed to.
                    if (M (qubits[1]) == res) 
                    {
                        set agree = agree + 1;
                    }

                    // Count the number of ones we saw:
                    if (res == One)
                    {
                        set numOnes = numOnes + 1;
                    }
                }

                // Need to reset the qubit back to zero now we have finished with it.
                Set(Zero, qubits[0]);
                Set(Zero, qubits[1]);
            }

            // Return number of times we saw a |0> and number of times we saw a |1>
            return (count-numOnes, numOnes, agree);
        }
    }
}
