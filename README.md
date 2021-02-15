# Fan-Speed-Controller

Part I. Introduction
   * Re-Engineering a YLFC700 Fan Speed Controller (TRIAC based). This controller was originally sourced from an Xtrodinair 42 Apex Fireplace. The problem with the controller is that the slide potentiometer fails over time (about every 2-years) at the slider's position that runs the fan just below max speed. 

Part II. Theory for Failure
   * The potentiometer is rated for 100[mW] and when an AC current source of ~120[Vac] is applied it goes out of specification. 
   * Keep in mind the potentiometer has a logarithmic range.

Part III. Parts
1. 18k,  (Min: 0.25[W], Bought: 0.5[W])
2. 240k, (Min: 0.25[W], Bought: 0.5[W])
3. 270k, (Min: 0.25[W], Bought: 0.5[W])
4. 2.4k, (Min: 0.5[W], Bought: 1[W])
5. BTA16-600B, TRIAC (non-insulated tab package)
6. DB3, DIAC (15 [uA] breakover current is my guess).
7. (2x) 100nF, Ceramic Capacitor 250V
8. 47nF, Ceramice Capacitor 400V
9. Inductor 7uH @ 1KHz (Measured with Scope, see Plot in Matlab folder)

Part III. LTspice Simulation
   * Running the LTSpice model created from the PCB components inside the YLFC700 shows that the potentiometer does fall out of spec. 
   * Note, that the Power Factor (PF) is approximately 84% in the potentiometer resistance range where the slider fails (10k to 30k).

Part IV. KiCAD Schematic & PCB Design
   * Since this Controller adjusts the blower's speed on the fireplace and this motor is rated for 1.8 [A], let's design the PCB for double the max operating current because we can :). 
   * The only difference from the original design is that a 4[A] fuse will be added, a toggle switch to disconnect the controller from the mains to recreated the off detent that was on the original board, and our design will not have any exposed PCB traces.
   * We will reuse the original cermaic capacitors, TRIAC, DIAC, and Choke Inductor since these components reactive components were engineered for this design.
   * A Bourns 91A1A-B28-A22L Knob Potentiometer (2[W], 2 to 250k [ohms], linear) will repalce the original slide potentiometer (100[mW], 30 to 300k [ohms], log). Since this potentiometer is in parallel with two other resistors, a 240k and 296k [ohms], the max resistance of the potentiometer doesn't matter that much. The minimum reistance does matter because it greatly affects the max speed (ie, the rate that the capacitors charge which control how the 120[Vac] sinewave is chopped; thereby, changing the fan speed. marvelous).
