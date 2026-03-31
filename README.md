# Developing a Multi-Personal 3D Simulation Environment with Efficient Path-Finding Algorithm

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**A high-performance, multi-user 3D research platform for observing and analyzing interactions between human participants and autonomous agents.**

This project is being developed as part of a seminar at the Technological University (Mandalay), Department of Computer Engineering and Information Technology.

---

## 📖 Project Overview

This project constructs a custom 3D rendering core to simulate a "Digital Vacuum"—a controlled, isolated space for high-fidelity interaction studies without real-world noise. It bridges high-performance graphics with Human-Centered AI (HAI) to study synergy between networking, persistent data, and behavioral modeling.

**Core Concept:** A multi-user environment where human-controlled avatars and AI-driven agents interact, with all behavioral data being tracked and saved for analysis.

---

## 🎯 Current Status & Vision

- **Current Phase:** Initial development of core systems.
- **Short-term Goal:** Implement a stable deferred shading pipeline and a basic client-server connection with MongoDB.
- **Long-term Vision:** A complete research framework for simulating unpredictable agent behaviors in strictly controlled, safe scenarios.

---

## ✨ Key Features (Planned)

- **Advanced 3D Graphics:** A custom OpenGL 3.3 Core engine utilizing a **Deferred Shading Pipeline**.
- **Persistent Multi-User System:** Login/sign-up system backed by a **Heartbeat Data Tracker** and **MongoDB**.
- **Intelligent Agents:** **A* Path-finding** and **Finite State Machines (FSM)** for agent behaviors.

---

## 🛠️ Tech Stack

- **Language:** C++17
- **Graphics API:** OpenGL 3.3 Core Profile, GLSL
- **Libraries:** Assimp, GLM, GLFW
- **Networking:** C++ Sockets
- **Database:** MongoDB
- **Algorithms:** A*, Finite State Machines (FSM)
- **Build System:** CMake

---

## 🚀 Getting Started (Initial Setup)

### Prerequisites
- C++17 compatible compiler (GCC, Clang, MSVC)
- OpenGL 3.3+
- CMake
- MongoDB
- Assimp / GLFW / GLM

### Installation

```bash
git clone https://github.com/[YOUR_USERNAME]/[YOUR_REPO_NAME].git
cd [YOUR_REPO_NAME]

mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
```

Run the program:
```bash
./MySimulationEngine
```

---

## 🧠 System Architecture (High-Level)

- **Rendering Layer:** Deferred Rendering (G-Buffer)
- **Infrastructure Layer:** Socket-based Heartbeat + MongoDB persistence
- **Navigation Module:** A* Pathfinding
- **Logic Module:** FSM Behavioral System

---

## 🤝 How to Contribute

1. Fork the project
2. Create your feature branch  
   `git checkout -b feature/AmazingIdea`
3. Commit your changes  
   `git commit -m 'Add AmazingIdea'`
4. Push to the branch  
   `git push origin feature/AmazingIdea`
5. Open a Pull Request

---

**Supervisor:** Dr. Thandar Soe, Professor

---

## 📄 License

This project is licensed under the MIT License — see the LICENSE file for details.
