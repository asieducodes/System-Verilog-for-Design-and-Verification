# SystemVerilog: Design & Verification

A hands-on learning repository for **SystemVerilog** covering both **RTL design** and **functional verification**. Concepts are studied from [ChipVerify](https://www.chipverify.com/) and every example is compiled and simulated with the **Cadence** toolchain (Xcelium / Incisive, with SimVision for waveform debug).

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
- Get comfortable with the Cadence simulation and debug flow.

---

## Repository Structure

```text
.
├── 01_basics/              # Data types, operators, procedural blocks
├── 02_design/              # RTL: combinational, sequential, FSMs, memories
├── 03_interfaces/          # Interfaces, modports, clocking blocks
├── 04_verification/        # Classes, randomization, mailboxes, generators
├── 05_assertions/          # Immediate and concurrent assertions (SVA)
├── 06_coverage/            # Covergroups, coverpoints, cross coverage
├── 07_uvm/                 # UVM testbench components
├── projects/               # Complete DUT + testbench mini-projects
├── scripts/                # Run scripts and Makefiles
└── README.md
```

> Adjust folder names to match your actual layout.

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
| Cadence Xcelium | Compile, elaborate, and simulate |
| Cadence SimVision | Waveform viewing and debug |
| Cadence vManager (optional) | Regression and coverage management |
| Git / GitHub | Version control |

---

## Getting Started

### Prerequisites

- Access to a Cadence installation with a valid license
- A Linux environment with the Cadence tools on your `PATH`
- Git


---

## Running a Simulation

Single-step flow with Xcelium:

```bash
xrun -sv -access +rwc -gui design.sv tb.sv
```

Common options:

| Flag | Description |
|------|-------------|
| `-sv` | Enable SystemVerilog |
| `-access +rwc` | Read/write/connectivity access for debug |
| `-gui` | Open SimVision |
| `-uvm` | Enable UVM support |
| `-coverage all` | Collect coverage |
| `-seed random` | Randomize the simulation seed |

Example with UVM and coverage:

```bash
xrun -sv -uvm -coverage all -covoverwrite +UVM_TESTNAME=my_test design.sv tb_top.sv
```

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
- Cadence Xcelium documentation (via Cadence Support)
- IEEE 1800: SystemVerilog Language Reference Manual

---

## Author

**Asiedu Seth Osei**
GitHub: [@asieducodes](https://github.com/asieducodes)

---

*This repository is for learning purposes. Contributions and suggestions are welcome.*
