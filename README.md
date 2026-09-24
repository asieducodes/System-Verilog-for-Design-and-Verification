# SystemVerilog: Design & Verification

A hands-on learning repository for **SystemVerilog** covering both **RTL design** and **functional verification**. Concepts are studied from [ChipVerify](https://www.chipverify.com/) and every example is compiled and simulated with the **Siemens EDA / Mentor Graphics QuestaSim** toolchain.

Each topic gets a small, self-contained example with a testbench, so the repo works as both a study log and a quick reference.

---

## Table of Contents

- [Goals](#goals)
- [Repository Structure](#repository-structure)
- [Topics Covered](#topics-covered)
- [Tools](#tools)
- [Getting Started](#getting-started)
- [Running a Simulation](#running-a-simulation)
- [Progress](#progress)
- [Resources](#resources)
- [Author](#author)

---

## Goals

- Build a solid foundation in synthesizable SystemVerilog RTL.
- Learn class-based, constrained-random verification.
- Progress toward UVM-style testbench architecture.
- Get comfortable with the QuestaSim simulation, GUI, and debug flow.

---

## Repository Structure

```text
.
├── .gitignore               # Excludes work libraries, transcripts, and WLF logs
├── README.md                # Main profile page
├── 01_basics/               # Data types, operators, procedural blocks
│   ├── arrays/              # Packed/unpacked, dynamic arrays, queues
│   ├── data_types/          # logic, bit, byte, int, enums, structs
│   └── procedural/          # always_comb, always_ff, always_latch
├── 02_design/               # RTL: combinational, sequential, FSMs, memories
│   ├── combinational/       # Muxes, decoders, ALUs
│   ├── sequential/          # Registers, counters
│   └── fsm/                 # Finite State Machines (Mealy/Moore)
├── 03_interfaces/           # Interfaces, modports, clocking blocks
│   ├── basic_interface/     # Simple wire bundling
│   └── advanced_interface/  # Modports and clocking blocks
├── 04_verification/         # Classes, randomization, mailboxes, generators
│   ├── 01_classes/          # OOP, handles, inheritance
│   ├── 02_randomization/    # rand, randc, constraint blocks
│   └── 03_ipc/              # Mailboxes, semaphores, events
├── 05_assertions/           # Immediate and concurrent assertions (SVA)
│   ├── immediate/
│   └── concurrent/          # SVA sequences and properties
├── 06_coverage/             # Covergroups, coverpoints, cross coverage
│   ├── code_coverage/
│   └── functional_coverage/ # Covergroups, coverpoints, cross coverage
├── 07_uvm/                  # UVM testbench components
│   ├── components/          # Driver, Monitor, Agent, Scoreboard
│   └── top/                 # UVM Test and Top module
├── projects/                # Complete DUT + testbench mini-projects
├── sim/                     # Dedicated run directory to isolate simulation clutter
└── scripts/                 # Automation Tcl run scripts and Makefiles
```

---

## Topics Covered

### Design
- [x] Data types: `logic`, `bit`, `int`, enums, structs, unions
- [x] Arrays: fixed, dynamic, associative, queues
- [ ] Combinational and sequential RTL (`always_comb`, `always_ff`, `always_latch`)
- [ ] Finite state machines
- [ ] Parameters, packages, and generate blocks

### Verification
- [ ] Interfaces, modports, and clocking blocks
- [ ] Testbench structure: driver, monitor, scoreboard
- [ ] Classes, inheritance, and polymorphism
- [ ] Constrained-random stimulus (`rand`, `randc`, constraints)
- [ ] Mailboxes, semaphores, and events
- [ ] SystemVerilog Assertions (SVA)
- [ ] Functional coverage
- [ ] Introduction to UVM

---

## Tools

| Tool | Purpose |
|------|---------|
| QuestaSim (vsim) | Compile, elaborate, and simulate HDL files [1] |
| QuestaSim GUI / Wave window | Waveform viewing, schematic viewer, and interactive debug [1] |
| VS Code | Source code editor (with SystemVerilog extension) |
| Git / GitHub | Version control |

---

## Getting Started

### Prerequisites

- Access to a QuestaSim / ModelSim installation with a valid license [1]
- A terminal environment (Windows Powershell/CMD or Linux shell) with `vsim` added to the system `PATH`
- Git

---

## Running a Simulation

### Using the Console (Isolated Sim Flow)
To keep the source code folders clean, navigate to the `sim/` folder and launch the simulation in batch mode or GUI mode using Tcl commands:

```bash
cd sim
vlib work
vlog -sv ../01_basics/data_types/design.sv ../01_basics/data_types/tb.sv
vsim -c work.tb -do "run -all; quit"
```

### Common QuestaSim Commands

| Command / Flag | Description |
|------|-------------|
| `vlib work` | Creates a local physical work library directory |
| `vlog -sv` | Compiles SystemVerilog source files |
| `vsim -c` | Runs the simulator in command-line / batch mode |
| `vsim -i` | Runs the simulator in interactive GUI mode |
| `vsim -voptargs="+acc"` | Preserves visibility of internal signals for waveform debugging |
| `restart -f` | Reloads modified compilation elements without closing the simulation environment |
| `quit -sim` | Gracefully terminates the active simulation instance and frees resources |

---

## Progress

| Topic | Status |
|-------|--------|
| SystemVerilog basics | In progress |
| RTL design | Not started |
| Interfaces and testbenches | Not started |
| Randomization and coverage | Not started |
| Assertions | Not started |
| UVM | Not started |

---

## Resources

- [ChipVerify: SystemVerilog Tutorial](https://www.chipverify.com/systemverilog/systemverilog-tutorial)
- [ChipVerify: UVM Tutorial](https://www.chipverify.com/uvm/uvm-tutorial)
- Siemens EDA QuestaSim Documentation (via InfoHub / Questasim Help)
- IEEE 1800: SystemVerilog Language Reference Manual

---

## Author

**Asiedu Seth Osei**
GitHub: [@asieducodes](https://github.com/asieducodes)

---

*This repository is for learning purposes. Contributions and suggestions are welcome.*
