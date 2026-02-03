---
title: System Verilog Implementation
parent: Cubic Fixed Point
nav_order: 2
has_children: false
---

# System Verilog Implementation

## Completing the System Verilog Module

There are several ways to implement the cubic polynomial function.  But, below is a simple three stage pipeline.
You can use this pipeline to guide your implementation.

- Stage 0:  Register all the inputs:  

```
x_s0 <= x, 
a0_s0 <= a0
a1_s0 <= a1
a2_s0 <= a2
```

- State 1:  
    - Compute the square and linear terms
    
```
x2_s1 <= fixed point ( x_s0 * x_s0 )
ax1_s1 <= fixed point (a1_s0 * x_s0 + a0_s0 )
```

     - Pass through `x_s0` and `a2_s0` since they will be needed in the final stage

```
x_s1 <= x_s0
a2_s1 <= a2_s0
```

- Stage 2 (combinational output):

```
x3 = fixed point( x_s1 * x2_s1 )
ax2 = fixed point( a2_s1 * x2_s1 )
y = fixed point( x3 + ax2 + ax1_s1 )
```

Here the challenge is to implement the fixed point implementations of the various products.
You will need to right shift each product and then saturate.  I have added a `sat` function to help
perform the saturation.  If you want, just ignore the saturation at first.  For the test vector with
`WID=16, FBITS=8`, there is no saturation.  So, you can get this working first.


## Completing the testbench

Once you have the module ready, complete the testbench code in `tb_cubic.sv`.  This file will read the test vector
inputs, instantiate your module as a DUT, run the inputs through your DUT module and compare the DUT outputs with
the outputs from the python golden model.

At the beginning of the testbench file you will see:

```
module tb_cubic;

    // Parameters
    localparam int WID = 16;
    localparam int FBITS = 8;
    ...
```

Change `FBITS=8` or `FBITS=12` as needed.  I would first test `FBITS=8` since this test case is easier to match.
Once you have selected the correct parameters,  the testbench can be run by using the `xilinxutils` function:

- Open a terminal in Unix or command window in Windows (On Windows, you cannot use Powershell)
- Activate the virtual environment with the `xilinxutils` package
- Follow the [instructions](../../docs/support/amd/lauching.md) to set the path for Vivado tools
- Navigate to the `hwdesign/labs/subc` directory
- Run

```bash
sv_sim --source cubic.sv --tb tb_cubic.sv
```

Note that if you are on the [NYU server](../../support/amd/nyu_remote.md), you will not have access
to the `xilinxutils` package.  So you will have to run the command `sv_sim` directly.
Assuming you cloned the `hwdesign` package in your home directory, run `sv_sim` as follows:

```bash
~/hwdesign/scripts/sv_sim --source cubic.sv --tb tb_cubic.sv
```



This will run the three steps in synthesizing and simulating the SV mdule.  The outputs will be stored in a CSV file, `test_outputs/tv_w16_f8_sv.csv`
or `test_outputs/tv_w16_f12_sv.csv` depending on the choice of `FBITS`.

You should see how many tests passed, and you can keep modifying the SV code until all test passed.

## Verify the test outputs

Once you have the tests passing, you can run the program:

```bash
python run_tests --tests sv_f8 
python run_tests --tests sv_f12 
```

These commands will tests that the test vectors match.

If you are running Vitis and Vivado on the [NYU machine](../../support/amd/nyu_remote.md),
you will not be able to run `python run_tests.py` since the python installation on that machine
is ancient and doesn't even the package `pandas`.  So, I suggest you copy the files above
to your local machine and run the `python run_tests.py` command there.



Go to [submission](./submit.md)