# Welcome to HeliosCap!

This is a "poorman" **heliostat** (solar celostat) that allows tracking the Sun easily with a fix telescope optical tube aiming polar north. It use hard drives disk as a flat mirror (more discussion latter), and a couple of inexpensive stepper motors (28BYJ-48) plus an arduino-like MCU. 

![GitHub Logo](/DecMotorFrame.jpg)

Test with Dec Motor frame only. RA motor still missing.

![GitHub Logo](/HeliosCap.gif)

Sun variying Dec during the year would require an elliptical mirror, but circular one is the only available option these days.

![GitHub Logo](/HeliosCapFrame.gif)

Inside a future tube, mirror will be steer to aim to any ecliptic objects, Moon and planets included.

It was designed during covid19 lock down in a small Atlantic island (La Palma), so no shopping was possible and only reuse of material available at home was feasible. I had a bunch of obsoletes 5" disk drives and knew that they are well polished, to avoid reading head crash so that was first choice to look for a flat mirror. Furthermore, even though their reflectivity is only around 60%, the Sun is really bright so the light lost after reflection even helps to reduce filters requirements and heat. In near future, hopeful when the lock down is over I hope to replace the mirror with a Newton Secondary elliptical one, and use a APO refractor lens to avoid central obstruction and obtain more contrast in resulting images.

The project is at testing phase, but the intention is to develop autonomous software to locate, track and even guide the Sun every day during the year, even in partially cloudy skies.

Leaving the optical tube fix and aligned to north (or south) pole will help in the second phase of the project, a bit more ambitious, that intend to build a DIY HelioSpectrograph. At least I have already the basic optical needs already available (scientific grid) adopting a Littrow configuration. to be continued... 

# Files

HeliosCap 3d parts have been designed with **OpenScad** in a parametric way, so one can adapt the sizes to its own telescope and flat mirror
# Software
A very simple soft will be provided using AccelStepper arduino library that allows HALFSTEP configuration for both RA and DEC motors. A second version, will use appropiate 3D printer like stepper driver and Nema motors for larger size version.
