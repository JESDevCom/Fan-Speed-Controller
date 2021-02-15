# Fan-Speed-Controller

Part I. Introduction
    Re-Engineering a YLFC700 Fan Speed Controller (TRIAC based). This controller was originally sourced from an Xtrodinair 42 Apex Fireplace. The problem with the controller is that the slide potentiometer fails over time (about every 2-years) at the slider's position that runs the fan just below max speed. 

Part II. Theory for Failure: 
   * The potentiometer is rated for 100[mW] and when an AC current source of ~120[Vac] is applied it goes out of specification. 
   * Keep in mind the potentiometer has a logarithmic range.

Part III. Simulation
   * Running the LTSpice model created from the PCB components inside the YLFC700 shows that the potentiometer does fall out of spec. 
   * Note, that the Power Factor (PF) is approximately 84% in the potentiometer resistance range where the slider fails (10k to 30k).
