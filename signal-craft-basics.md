---
layout: default
title: Signal Craft Basics
---

# Signal Craft Basics

## What is radio?
Radio is just electromagnetic waves—the same family as light, Wi-Fi, or microwaves—just at lower frequencies, so you can’t see them. Instead of glowing, they travel invisibly through the air, carrying information when you modulate them.

- **Frequency (Hz):** cycles per second.  
- **Wavelength (m):** how long each cycle is in space.  
- **Relationship:** frequency × wavelength = speed of light (~300,000 km/s).

Example: a 100 MHz FM station has a wavelength of ~3 m. That’s why car antennas are about 1 m long—they resonate at those waves.

## Anatomy of a radio circuit
Even advanced radios boil down to the same core blocks:

1. **Antenna** — ears or mouth for radio waves. Picks up energy or launches it.  
2. **Tuner** — selects one frequency and ignores the rest. Usually an **LC circuit** (inductor + capacitor).  
3. **Detector / Demodulator** — strips off the carrier and leaves the signal. A diode can do AM; FM needs more elaborate circuits.  
4. **Amplifier** — boosts the tiny detected signal so you can hear it.  
5. **Power source** — the unsung hero. Radios don’t run on vibes.

## Two main modulation styles
- **AM (Amplitude Modulation):** change the wave’s height. Simple to build (crystal radios), but static-prone.  
- **FM (Frequency Modulation):** change the spacing of wave peaks. Cleaner sound, trickier circuits.

## Why resonance matters
That LC circuit in your tuner is your radio’s filter. An inductor and a capacitor “ring” at one frequency. Adjust the coil or capacitor, and you retune your radio’s ear.

## A simple project
Try a crystal radio:

- Coil: 50–100 turns of wire on a cardboard tube  
- Capacitor: a small variable capacitor (from an old radio, or cheap online)  
- Detector: germanium diode (e.g., 1N34A)  
- Load: high-impedance earbud  
- Antenna: long wire  
- Ground: water pipe, metal rod in earth, etc.  

The station’s energy powers the headphones—no batteries needed.

---

*Signal craft begins here: understanding waves, building circuits, and listening to the invisible world around us.*
