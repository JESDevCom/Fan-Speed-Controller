# Fan-Speed-Controller

Part I. Introduction
   * Re-Engineering a YLFC700 Fan Speed Controller (TRIAC based). This controller was originally sourced from an Xtrodinair 42 Apex Fireplace. The problem with the controller is that the slide potentiometer fails over time (about every 2-years) at the slider's position that runs the fan just below max speed. 

Part II. Theory for Failure
   * The potentiometer is rated for 100[mW] and when an AC current source of ~120[Vac] is applied it goes out of specification. 
   * Keep in mind the potentiometer has a logarithmic range.
   
Part III. Testing Equipment Used
1. Fluke 87V Digital Multimeter
2. Siglent SDS 1104X-E 100MHz Oscilloscope
3. Krohn-Hite Model 1600 3MHz Frequency Generator
4. Generic 5[V] 1[A] Fixed Power Supply
5. Hakko Soldering Station
6. Quick Hot Air Soldering Station

Part IV. Software Used
1. Windows 10 Pro
2. KiCAD 5.1
3. Matlab

Part V. Parts
1. 18k,  (Min: 0.25[W], Bought: 0.5[W])
2. 240k, (Min: 0.25[W], Bought: 0.5[W])
3. 270k, (Min: 0.25[W], Bought: 0.5[W])
4. 2.4k, (Min: 0.5[W], Bought: 1[W])
5. 24, (Bought: 1[W])
5. 91A1A-B28-A22L, 0.2 [Ohms] to 250 [kOhms] Linear Potentiometer, Turn Knob Style, 2[W] max.
6. BTA16-600B, TRIAC (non-insulated tab package)
7. DB3, DIAC (15 [uA] breakover current is my guess).
8. 100[nF], Ceramic Capacitor 250[V]
9. 100[nF], Ceramic Capacitor 250[V]
9. 47[nF], Ceramice Capacitor 400[V]
10. Inductor 7[uH] @ 1[KHz] (Measured with Scope, see Plot in Matlab folder)
11. 1/4" Dia. Metal Knob for Potentiometer

Part VI. LTspice Simulation
   * Running the LTSpice model created from the PCB components inside the YLFC700 shows that the potentiometer does fall out of spec. 
   * Note, that the Power Factor (PF) is approximately 84% in the potentiometer resistance range where the slider fails (10k to 30k).

Part VII. KiCAD Schematic
   * Since this Controller adjusts the blower's speed on the fireplace and this motor is rated for 1.8 [A], let's design the PCB for double the max operating current because we can :). 
   * The only difference from the original design is that a 4[A] fuse will be added, a 24 Ohm resistor, a toggle switch to disconnect the controller from the mains to recreated the off detent that was on the original board, and our design will not have any exposed PCB traces.
   * We will reuse the original cermaic capacitors, TRIAC, DIAC, and Inductor since these reactive components were engineered for use in the original design.
   * A Bourns 91A1A-B28-A22L Knob Potentiometer (2[W], 0.2 to 250k [Ohms], linear) will repalce the original slide potentiometer (100[mW], 30 to 300k [Ohms], log). Since this potentiometer is in parallel with two other resistors, a 240k and 296k [ohms], the max resistance of the potentiometer doesn't matter that much. However, the minimum reistance does matter because it greatly affects the max speed (ie, the resistance controls rate that the capacitors charges, which controls how the 120[Vac] sinewave is chopped; thereby, changing the fan speed. marvelous).
   * Since the potentiometer goes down to 0.2 [Ohms], an excessive amount of current is drawn across the potentiometer, so a 24 Ohm resistor will be added in series with the potentiometer to approximately match the original slide potentiometer's minimum resistance. 
  
 Part VIII. KiCAD PCB Design
   * A two-side PCB will be created and fabricated, I used OSHpark.
   * SMD resistors for the 18k, 240k, 270k, 24 Ohm Resistors are required to make space for the Knob Potentiometer.
   * Certain traces that follow from VAC input, to the TRIAC, and out to the motor must be fat traces (4mm) to stay below current and heat limits of having covered traces.
   * 0.2mm minimum distance between traces is important for 120[Vac] designs.
 
Part IX. Results
   * TBD
  
   
Part X. Legal Agreement
 
Under the MIT license to this project, you may use this design freely. An email to alledgedlyengineering @ gmail stating that you used this design would be nice to know. By using this project you are agreeing to the risks involved with AC current and altering a UL listed product to fit your needs. In addition, you agree to not hold me responsible for any injury or result of injury incurred by modifying the YLFC700 Fan Speed Controller. This project has no affliations with any of the manufacturers used in this design or the PCB fabrication house used.  
