ILI9341 SPI LCD with NUCLEO-F429ZI
===

use CN7 of NUCLEO-F429ZI to connection the SPI LCD

the code base on [LCDWIKI reference code](http://www.lcdwiki.com/res/Program/Common_SPI/2.4inch/SPI_ILI9341_MSP2402_V1.1/2.4inch_SPI_Module_ILI9341_MSP2402_V1.1.zip)

to modify for NUCLEO-F429ZI and use gcc arm/cmake for build

 SPI data signal of LCD
 -----
     LCD Module            NUCLEO-F429ZI
     SDI(MOSI)   <->         PA7          // SPI Data Input/SPI Master Output Slave Input
     SDO(MISO)   <->         PA6          // SPI Data Output/SPI Master Input Slave Output, option connection
 LCD control signal
 ----
     LCD Module            NUCLEO-F429ZI
     LED         <->         PB9          // Backlight control
     SCK         <->         PA5          // clock of SPI
     DC/RS       <->         PD14         // Data/Control indicator signal
     RST         <->         PD15         // Reset of LCD
     CS          <->         PF12         // chip select of SPI
