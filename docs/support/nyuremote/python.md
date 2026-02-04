---
title: Using Python
parent: NYU Remote Server
nav_order: 4
has_children: False
---

## Using Python

The course uses python scripts for running many of the simulations
and analysis..
Right now, the python installation on the NYU machine is very old and has very few 
packages.  So I suggest that you run the Vitis and Vivado on the NYU server.
Then, for python post processing, copy the files from the remote machine to your local machine
and run the commands there.

Note that the first labs use the script `sv_sim`.  This is also part of a python 
package that you will not have access to on the remote machine.  To run this script, I suggest the following

* Clone the git repository to your home directory

```bash
cd ~
git clone https://github.com/sdrangan/hwdesign.git
```

* Navigate to the lab or demo you want to do.  For example, for the first lab:

```bash
cd hwdesign/labs/subc
```

* You can now run the file from `sv_sim` from any directory via:

```bash
python3 ~/hwdesign/xilinxutils/scripts/sv_sim.py --source <sourcefiles> --tb <tbfiles>
```

    