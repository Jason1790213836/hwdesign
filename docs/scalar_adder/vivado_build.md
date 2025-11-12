---
title: Creating the Vivado Project
parent: Getting started
nav_order: 1
has_children: false
---

# Creating the Vivado project

We first create an Vivado project with the MPSOC.

* Launch Vivado (see the [installation instructions]({{ site.baseurl }}/docs/installation.md#launching-vivado)):
* Select the menu option **File->Project->New...**.
   * For the project name, select a `<project_name>` based on the target FPGA boards":
      * For the RFSoC4x2, use `scalar_adder_rfsoc`.  
      * For the PynqZ2, use `scalar_adder_pynqz2`.  
   * In location, use the directory `fpgademos/scalar_adder`.  The Vivado project will then be stored in `scalar_adder/scalar_adder_vivado` or `scalar_adder/<project_name>`.
* Select ***RTL project**.  
   * Leave **Do not specify sources at this time** checked.
* For **Default part**, select the **Boards** tab.
    * If you are targetting a RFSoC 4x2, select `Zynq UltraScale+ RFSoC 4x2 Development Board`.
    * If you are targetting a Pynq Z2, select `pynq-z2`.
* The Vivado window should now open with a blank project.
* You will see a number of files including the project directory, `scalar_adder\<project name>`.
* On the **Flow Navigator** panel (left sidebar), select **IP Integrator->Create Block Design**
    * You can use the suggested name `design_1`
* Now select **IP Integrator->Open Block Design**.  You will see an empty block Ddesign
* Add the processing system.
    * Select the **Add IP** button in the block design (it is a cross)
    * For the Pynq-Z2, select `ZYNQ7`.
    * For the RFSoC4x2, select something like `Zynq MPSoC` [I will try to fix this]
* Run the **Run Block Automation** option that should appear in the top of the block diagram.  The block automation will configure the processor system for the board.
* Before the next step, we need to to find the precise target part number of the FPGA that the IP will run on.  This target part number will be used for Vitis in the next step:
   * Select the menu option **Report->Report IP Status**.  This will open a panel **IP status** at the bottom.
   * If you are using the RFSoC4x2, in the panel, you can see the part number for something like `/zynq_ultra_ps_e_0`.  That part number will be something like `xczu48dr-ffvg1517-2-e`
   * For the Pynq-Z2, the part is something like `/processing_system7_0` and the part number is something like `xc7z020clg400-1`

---

Go to [Creating the Vitis IP](./vitis_ip.md)