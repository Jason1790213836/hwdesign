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
This will typically use a format of the form:
~~~bash
    vitis-run --mode hls --tcl <tclfile.tcl>
~~~
where `tclfile.tcl` is a so-called TCL file, a scripting file that will configure the operations to be performed.

To launch the Vitis GUI or `vitis` or `vitis-run` from the command line:

* Determine where the vitis tool is located:
    * In Linux: `vitis` and `vitis-run` are typically located in a directory like `/tools/Xilinx/Vitis/2025.1`
    * In Windows: `vitis` and `vitis-run` are typically located in a directory like `c:\Xilinx\2025.1\Vitis`
* In that directory:
    * In Linux, run `source settings64.sh`
    * In Windows Command Shell (not Powershell), run: `settings64.bat` 
* Then, in the terminal run:
    * `vitis` for the Vitis GUI
    * `vitis-run --mode hls --tcl <tclfile.tcl>`


