﻿using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Bell
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                Result[] initials = { Result.Zero, Result.One };

                foreach (Result initial in initials)
                {
                    // Do 1000 runs on the simular.
                    // Run() is async so call Result to make it synchronous.
                    var res = BellTest.Run(sim, 1000, initial).Result;

                    var (numZeros, numOnes, agree) = res;

                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree,-4}");
                }

            }

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}