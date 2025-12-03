---
title: Launching Vitis and Vivado
parent: Vitis and Vivado
nav_order: 2
has_children: false
---

# Launching Vitis and Vivado

## Launching Vivado GUI 

In Windows, you launch the Vivado GUI from the **Start menu** by clicking the Windows button
 and typing "Vivado" into the search bar.

You can also start the GUI from a command terminal in either Linux or Windows as follows:

* In Windows, open a Command Shell, not a Powershell
* Find the path the Vivado for the version you want to use:
    * On Linux, it is likely in `/tools/Xilinx/Vivado/2025.1`  
    * On Windows, is is likely in `c:\Xilinx\2025.1\Vivado`
* Run the settings command:
    * On Linux: `source <vivado_path>/settings64.sh`
    * On Windows: `<vivado_path>/settings64.bat` 
* Run `vivado` from the command line.
* The Vivado GUI should launch
* In Windows, you can also use a Powershell, but the settings command will not set the path.
    * For Powershell, skip runnings `settings64.bat`
    * Directly call Vivado with
~~~bash
    > c:\Xilinx\2025.1\Vivado\bin\vivado.bat
~~~

## Launching Vitis 

For Vitis, there are two main ways you’ll interact with the tools:

* **Vitis GUI**:  A graphical IDE for designing applications, managing projects, simulating, and analyzing kernels. This is the environment you open from the Start menu or by running `vitis`.
* **Command-line HLS compilation**:  Used for synthesizing C/C++ kernels into RTL and simulating them.
    - In **2024.1 and earlier**, this was done with the standalone tool `vitis_hls`.
    - In **2025.1**, `vitis_hls` has been retired, and the functionality is now part of the unified compiler:  `v++ --mode hls`
    - So `v++` is the command you use for HLS kernel synthesis and simulation

To launch the vitis GUI or `v++` from the command line:

* Determine where the vitis tool is located:
    * In Linux: `vitis` and `v++` are typically located in a directory like `/tools/Xilinx/Vitis/2025.1`
    * In Windows: `vitis` and `v++` are typically located in a directory like `c:\Xilinx\2025.1\Vitis`
    * For the older `vitis_hls` tool, it is located in `/tools/Xilinx/<version>/Vitis_HLS/` or `c:\Xilinx\<version>\Vitis_HLS`
* In that directory:
    * In Linux, run `source settings64.sh`
    * In Windows Command Shell (not Powershell), run: `settings64.bat` 
* Then, in the terminal run:
    * `vitis` for the Vitis GUI
    * `vitis_hls [options]` or `v++ --mode hls [options]` for the HLS compilation tool.


