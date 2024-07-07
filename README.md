# Space Invaders Game on FPGA

## Overview

This project is the final project for ECE 540 - System on Chip Design with FPGA at Portland State University. The goal was to design and implement a custom game similar to "Space Invaders" on the Diligent Nexys A7-100T FPGA board, utilizing a peripheral Android controller for gameplay.

## Project Contributors

- **Alexander Maso** (amaso@pdx.edu)
- **Rutuja Muttha**

## Project Description

### General Design

The FPGA board controls all the image data and the functionality of the game. All sprites are generated through the manipulation of VGA output to control individual pixels. Each sprite has its own module to hold position and movement data. The movement of the "Space Invaders" and the missiles is implemented using a Finite State Machine (FSM) and a counter. The Android app serves as the game controller, connecting to the FPGA board via an ESP32 microcontroller using Bluetooth Low Energy (BLE).

### Block Diagram

![Block Diagram](./docs/Block_Diagram.pdf)

### Features

- **FPGA Implementation:**
  - Sprite generation for player and alien ships
  - Movement control for sprites using FSM
  - Missile firing and collision detection
  - VGA output for game display

- **Android App Controller:**
  - HUD display for game status
  - Control buttons for player movement and actions
  - Bluetooth connection to FPGA via ESP32
  - Sound effects managed by the Android app

### Milestones

#### Alexander Maso

1. **Initial Sprite Implementation:**
   - Player and alien sprites generated and displayed.
   - Movement logic for sprites using FSM.
   - Player sprite controlled through push buttons.

2. **Missile Logic:**
   - Player and alien missiles implemented.
   - Collision detection and interaction between sprites.
   
3. **Advanced Features:**
   - Defensive barriers for the player.
   - Alien sprites with distinct designs and animations.
   - Integration of Android app for control via BLE.

#### Rutuja Muttha

1. **Connection Setup:**
   - BLE connection between Android app and ESP32.
   
2. **Android App Development:**
   - Layout design and interaction setup.
   - Control logic for player actions.
   
3. **Integration and Testing:**
   - Communication between Android app and FPGA.
   - HUD implementation and sound effects.

## Challenges

- **Sprite Management:**
  - Initially, all sprite logic was in the VGA module, causing complexity.
  - Solution: Separate modules for each sprite and use the VGA module for display logic only.

- **Missile Logic:**
  - Ensuring missiles are controlled accurately with collision detection.
  - Solution: Use registers and FSM for missile enable/disable based on game events.

- **Team Coordination:**
  - Difficulty in coordinating tasks and deliverables.
  - Solution: Separate reports and clear division of work.

## Conclusion

This project provided valuable experience in FPGA design, game development, and integrating hardware with software controllers. The successful implementation of "Space Invaders" demonstrated the capabilities of FPGA for real-time game applications and the effective use of Android apps as controllers.

## Documentation

- [Final Project Report](./docs/Final_Project_Report.pdf)
- [Interim Report - Alex](./docs/Interim_Report_Alex.pdf)
- [Interim Report - Rutuja](./docs/Interim_Report_Rutuja.pdf)
- [Project Proposal](./docs/Project_Proposal.pdf)

## Contact

For any questions or further information, please contact:
- Alexander Maso: amaso@pdx.edu
- Rutuja Muttha: 
