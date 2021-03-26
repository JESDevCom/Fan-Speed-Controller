# Fan-Speed-Controller

**Part I. Introduction**
   * Re-Engineering a YLFC700 Fan Speed Controller (TRIAC based). This controller was originally sourced from an Xtrodinair Apex 42 Fireplace. The problem with the controller is that the slide potentiometer fails over time (about every 2-years). It fails at the slider's position where the fan runs just below max speed. 

**Part II. Theory for Failure**
   * The potentiometer is rated for 100[mW].
   * The reason the potentiometer fails is because the 47 [nF] Film capacitor begins to fail from transient voltage spikes after many startups.
   
**Part III. Testing Equipment Used**
1. Fluke 87V Digital Multimeter
2. Siglent SDS 1104X-E 100MHz Oscilloscope
3. Krohn-Hite Model 1600 3MHz Frequency Generator
4. Generic 5[V] 1[A] Fixed Power Supply
5. Hakko Soldering Station
6. Quick Hot Air Soldering Station

**Part IV. Software Used**
1. Windows 10 Pro
2. KiCAD 5.1
3. Matlab

**Part V. Parts Used**
1. RV1, 91A1A-B28-A22L, 0.2 [Ohms] to 250 [kOhms] Linear Potentiometer, Turn Knob Style, 2[W] max.
2. R1, 2.4k, Reused
3. R2, 270k, (Min: 0.25[W], Bought: 0.5[W])
4. R3, 18k,  (Min: 0.25[W], Bought: 0.5[W])
5. R4, 240k, (Min: 0.25[W], Bought: 0.5[W])
6. R5, 24, (Bought: 1[W])
7. U1, BTA16-600B, TRIAC (non-insulated tab package)
8. U2, DB3, DIAC (15 [uA] breakover current is my guess).
9. C3, 100 [nF], Film Capacitor 250[Vdc]
10. C2, 100[nF], Film Capacitor 250[Vdc]
11. C1, 47[nF], Ceramic Capacitor 1 [kVdc] (X7R)
12. L1, Inductor 7[uH] @ 1[KHz] (Measured with Scope, see characterization plot in Matlab folder)
13. 1/4" Dia. Metal Knob for Potentiometer

**Part VI. LTspice Simulation**
   * As the 47 [nF] fails, the potentiometer begins to seriously fall out of spec. 
   * Note, that the Power Factor (PF) is approximately 86% in the potentiometer resistance range where the slider fails (100 to 30k).

**Part VII. KiCAD Schematic**
   * Since this Controller adjusts the blower's speed on the fireplace and this motor is rated for 1.8 [A], let's design the PCB for double the max operating current because we can :). 
   * The only added components from the original design:
      1. 4 [A] fuse will be added, 
      2. a 24 [Ohm] resistor will be added in series with the potentionmeter since the potentiometer's minimum resistance is 0.2 [Ohms],
      3. a toggle switch to disconnect the controller from the 120 Volt mains to recreated the off detent that was on the original board, 
      4. and my design will not have any exposed PCB traces from the Fab.
      
   * We will reuse:
      1. 2.4k through-hole resistor,
      2. the two 100 [nF] film capacitors, 
      3. TRIAC, 
      4. DIAC, 
      5. and Inductor since these reactive components were engineered for use in the original design.

   * We will replace:
      1. 18k through-hole with a 18k in a 1206 package,
      2. 240k through-hole with a 240k in a 1206 package,
      3. 270k through-hole with a 270k in a 1206 package,
      4. the no-name slide potentiometer with a Bourns 91A1A-B28-A22L Knob Potentiometer,
      5. 47 [nF] 400 [Vdc] Radial Film Capacitor with a 47 [nF] 1 [kVdc] (X7R) Radial Ceramic Capacitor
     
   * A Bourns 91A1A-B28-A22L Knob Potentiometer (2[W], 0.2 to 250k [Ohms], linear) will repalce the original slide potentiometer (100[mW], 30 to 300k [Ohms], log). Since this potentiometer is in parallel with two other resistors, a 240k and 296k [ohms], the max resistance of the potentiometer doesn't matter that much. However, the minimum reistance does matter because it greatly affects the max speed (ie, the potentiometer controls the rate that the capacitors charge, which controls how the 120 [Vac] sinewave is chopped; thereby, changing the fan speed. marvelous).
   * Since the potentiometer goes down to 0.2 [Ohms], an excessive amount of current is drawn across the potentiometer, so a 24 Ohm resistor will be added in series with the potentiometer to approximately match the original slide potentiometer's minimum resistance. 
  
 **Part VIII. KiCAD PCB Design**
   * A two-side PCB will be created and fabricated, I used OSHpark as the frabricator.
   * SMD resistors for the 18k, 240k, 270k, 24 Ohm Resistors are required to make space for the Knob Potentiometer.
   * Certain traces that follow from the VAC input, to the TRIAC, and out to the motor must be fat traces (4mm) to stay below current and heat limits of having covered traces.
   * 0.2mm minimum distance between traces is important for 120[Vac] designs.

**Part IX. Disassembly of Original Boar & Removal of Components**
   * Remove the plastic & copper PCB mounting stands that connect the PCB to the metal outlet mount.
   * Use a Soldering Iron or Hot Air Station to remove the inductor, DIAC, TRIAC, and Capacitors.
   * Check capacitors with Fluke 87V.
   * Resolder the new and old components to the new board. 

**Part X. Results**
   * When removing the capacitors from the original board, the 47 [nF] Film Capacitor was measured at 1.2 [nF]. The 100 [nF] film capacitors were still in 10% spec.
   * After simulating the LTspice model with such a value (1.0nF) it became clear that the reason the potentiometer failed was because the 47 [nF] capacitor failed. This 47 [nF] capacitor is marked C1 on the original board (YLFC700).
   * Reason for failure: the capacitor is configured as a snubber and there is likely overvoltage spikes due to the motor.
   * Solution: Use a cermaic capacitor that has a higher maximum voltage rating that can withstand spikes resulting from the TRIAC switching. 
   
   * Successfully operating as of March 2021.
  
   
**Part XI. Legal Notice**
 
Under the MIT license to this project, you may use this design freely. An email to alledgedlyengineering @ gmail stating that you used this design would be nice to know. By using this project you are agreeing to the risks involved with AC current and altering a UL listed product to fit your needs. In addition, you agree to not hold me responsible for any injury or result of injury incurred by modifying the YLFC700 Fan Speed Controller. This project has no affliations with any of the manufacturers used in this design or the PCB fabrication house used.  
