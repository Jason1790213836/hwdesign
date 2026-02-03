---
title: Submitting the Lab
parent: Cubic Fixed Poin
nav_order: 3
has_children: true
---

# Submitting the Lab

For NYU students that want to receive credit for the lab,
if you are running the Vitis and Vivado on your local machine, 
run the python command:

```bash
python run_tests.py --tests all --submit
```

This program will look at the test vectors and validate that the tests have passed.
The program will create a zip file `submission.zip` with:

- `submitted_results.json`:  A JSON file with the test results
- `cubic.ipynb`:  Your python implementation
- `cubic.sv`:  Your SV implementation
- `tb_cubic.sv`:  Your SV testbench implementation
- `test_results/tv_....csv`:  Various test vectors

Submit this zip folder on Gradescope on the lab assignment.  A Gradescope autograder will upload the grade. 

If you are running Vitis and Vivado on the [NYU machine](../../support/amd/nyu_remote.md),
you will not be able to run `python run_tests.py` since the python installation on that machine
is ancient and doesn't even the package `pandas`.  So, I suggest you copy the files above
to your local machine and run the `python run_tests.py` command there.

