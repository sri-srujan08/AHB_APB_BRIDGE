Advanced High-performance Bus (AHB) : The AMBA AHB is for high-performace, high clock frequency system modules. The AHB acts as the high-performance system backbone bus. AHB supports the efficient connection of processors, on-chip memories and off-chip external memory interfaces with low-peripheral macrocell functions. AHB is also specified to ensure ease of use in an efficient design flow using synthesis and automated test techniques.

Advanced Peripheral Bus (APB) : The AMBA APB is for low-power peripherals. AMBA APB is optimized for minimal power consumption and reduced interface complexity to support peripheral functions. APB can be used in conjunction with either version of the system bus. 

The AHB to APB bridge is an interface which converts the AHB signals for APB to understand. My objective here is to verify the AHB to APB bridge using System Verilog. Verification in general terms means - whether the Design Under Test (DUT) is functioning properly as per the protocol when the stimulus is driven. 

I've written the System Verilog code and generated the Coverage report. While there is always a room for improving the coverage, the main idea is to satiate whether the functionality is being covered or not. 

The regression test is also been added, and is a part of the MakeFile. The MakeFile has the necessary targets to compile and run the program. The coverage I'm getting is around 75%, so one can play around and try to increase it. I shall continue to work on it, and shall update it with a better coverage report percentage.
