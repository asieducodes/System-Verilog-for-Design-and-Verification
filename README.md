# SystemVerilog: Design & Verification

A hands-on learning repository for **SystemVerilog** covering both **RTL design** and **functional verification**. Concepts are studied from [ChipVerify](https://www.chipverify.com/) and every example is compiled and simulated with **Siemens EDA QuestaSim**.

Each topic gets a small, self-contained example with a testbench, plus screenshots of the waveform and schematic, so the repo works as both a study log and a quick reference. A companion file, [EXERCISES.md](EXERCISES.md), holds practice questions and self-assessment gates for every chapter.

---

## Table of Contents

- [Goals](#goals)
- [Repository Structure](#repository-structure)
- [Topics Covered](#topics-covered)
- [Tools](#tools)
- [Getting Started](#getting-started)
- [Running a Simulation](#running-a-simulation)
- [Exercise Folder Convention](#exercise-folder-convention)
- [Progress](#progress)
- [Resources](#resources)
- [Author](#author)

---

## Goals

- Build a solid foundation in synthesizable SystemVerilog RTL.
- Learn class-based, constrained-random verification.
- Progress toward UVM-style testbench architecture.
- Get comfortable with the QuestaSim simulation, wave window, and debug flow.
- Document every example with code, results, and images.

---

## Repository Structure

```text
System-Verilog-for-Design-and-Verification/
├── .gitignore                    # Excludes work libraries, transcripts, WLF logs
├── README.md                     # This file
├── EXERCISES.md                  # Practice questions and mastery gates
│
├── 01_basics/                    # Language fundamentals
│   ├── data_types/               # logic, bit, byte, int, enums, structs
│   ├── arrays/                   # Packed/unpacked, dynamic, associative, queues
│   └── procedural/               # always_comb, always_ff, always_latch
│
├── 02_design/                    # RTL design
│   ├── combinational/            # Muxes, decoders, encoders, ALU
│   │   └── ex_04_alu/
│   │       ├── design.sv
│   │       ├── tb.sv
│   │       ├── wave.do           # Saved waveform setup
│   │       ├── README.md         # Short write-up for this exercise
│   │       └── images/
│   │           ├── waveform.png
│   │           └── schematic.png
│   ├── sequential/               # Registers, counters, shift registers
│   ├── fsm/                      # Moore and Mealy machines
│   └── parameters_generate/      # Parameters, packages, generate blocks
│
├── 03_interfaces/                # Interfaces, modports, clocking blocks
│   ├── basic_interface/
│   └── advanced_interface/
│
├── 04_verification/              # Class-based verification
│   ├── 01_classes/               # OOP, handles, inheritance
│   ├── 02_randomization/         # rand, randc, constraints
│   ├── 03_ipc/                   # Mailboxes, semaphores, events
│   └── 04_layered_tb/            # Generator, driver, monitor, scoreboard (no UVM)
│
├── 05_assertions/                # SystemVerilog Assertions (SVA)
│   ├── immediate/
│   └── concurrent/
│
├── 06_coverage/                  # Coverage
│   ├── code_coverage/
│   └── functional_coverage/
│
├── 07_uvm/                       # UVM
│   ├── components/               # Driver, monitor, agent, scoreboard
│   └── top/                      # Test and top module
│
├── projects/                     # Complete mini-projects
│   ├── p1_sync_fifo/
│   ├── p2_uart_tx/
│   ├── p3_register_file/
│   └── p4_alu_uvm_env/
│
├── scripts/                      # Automation
│   ├── sim.do                    # Main compile + simulate + wave script
│   └── sim_uvm.do                # Added later for UVM runs
│
├── templates/
│   └── TEMPLATE_README.md        # Copy into each new exercise folder
│
└── sim/                          # Run directory (git-ignored, recreate with mkdir sim)
```

Each exercise lives in its own `ex_<number>_<name>/` folder inside the matching topic folder. Only the `ex_04_alu` example is expanded above; the others follow the same pattern.

---

## Topics Covered

### 01 Basics
- [x] Data types: `logic`, `bit`, `int`, enums, structs, unions
- [x] Arrays: fixed, dynamic, associative, queues
- [ ] Procedural blocks: `always_comb`, `always_ff`, `always_latch`

### 02 Design
- [ ] Combinational logic (mux, decoder, encoder, ALU)
- [ ] Sequential logic (registers, counters, shift registers)
- [ ] Finite state machines (Moore and Mealy)
- [ ] Parameters, packages, and generate blocks

### 03 Interfaces
- [ ] Interfaces and modports
- [ ] Clocking blocks and virtual interfaces

### 04 Verification
- [ ] Classes, inheritance, and polymorphism
- [ ] Constrained-random stimulus (`rand`, `randc`, constraints)
- [ ] Mailboxes, semaphores, and events
- [ ] Layered testbench: driver, monitor, scoreboard

### 05 Assertions
- [ ] Immediate assertions
- [ ] Concurrent assertions (SVA sequences and properties)

### 06 Coverage
- [ ] Code coverage
- [ ] Functional coverage (covergroups, coverpoints, cross)

### 07 UVM
- [ ] UVM components, phases, and factory
- [ ] Sequences, agents, and scoreboards

---

## Tools

| Tool | Purpose |
|------|---------|
| QuestaSim (`vlib`, `vlog`, `vsim`) | Compile, elaborate, and simulate |
| QuestaSim Wave and Schematic windows | Waveform viewing and design debug |
| VS Code | Source editor (with a SystemVerilog extension) |
| Git / GitHub | Version control |

---

## Getting Started

### Prerequisites

- A QuestaSim installation with a valid license
- `vsim` and `vlog` available on the system `PATH`
- Git and a terminal (Git Bash, PowerShell, or a Linux shell)

### Clone the repository

```bash
git clone https://github.com/asieducodes/System-Verilog-for-Design-and-Verification.git
cd System-Verilog-for-Design-and-Verification
mkdir sim
```

---

## Running a Simulation

Always run QuestaSim from the `sim/` folder. Generated files (the `work` library, transcript, and waveform database) stay there and never clutter the source folders.

### Option 1: Console (quick check)

```bash
cd sim
vlib work
vlog -sv ../02_design/combinational/ex_04_alu/design.sv ../02_design/combinational/ex_04_alu/tb.sv
vsim -c -quiet work.<top_module> -do "run -all; quit -f"
```

Replace `<top_module>` with the **module name** inside your testbench, not the file name. Testbenches should end with `$finish` so `run -all` does not hang.

### Option 2: Script with waveforms (GUI)

```bash
cd sim
vsim -do ../scripts/sim.do
```

For a new exercise, change only the two `set` lines at the top of `scripts/sim.do`:

```tcl
set DIR ../02_design/combinational/ex_04_alu
set TOP tb_alu

.main clear
catch {quit -sim}

if {[file exists work]} { vdel -lib work -all }
vlib work

vlog -sv $DIR/design.sv $DIR/tb.sv

vsim -voptargs=+acc work.$TOP
log -r /*
add wave -position insertpoint sim:/$TOP/*
run -all
wave zoom full
```

### Common QuestaSim commands

| Command / Flag | Description |
|------|-------------|
| `vlib work` | Creates the `work` library directory |
| `vdel -lib work -all` | Deletes the library so you can start clean |
| `vlog -sv <files>` | Compiles SystemVerilog source files |
| `vsim -c` | Runs the simulator in console (batch) mode |
| `vsim -gui` | Opens the simulator with the GUI |
| `vsim -voptargs=+acc` | Keeps internal signals visible for waveform debugging |
| `run -all` | Runs until the simulation finishes |
| `restart -f` | Restarts the simulation from time 0 without a confirmation prompt. Recompile with `vlog` first if you changed the code |
| `quit -sim` | Ends the current simulation but keeps QuestaSim open |
| `quit -f` | Exits QuestaSim without a confirmation prompt |

### `.gitignore`

```gitignore
# QuestaSim / ModelSim
sim/
work/
*_lib/
transcript
vsim.wlf
modelsim.ini
*.wlf
*.vcd
```

---

## Exercise Folder Convention

Every exercise follows the same layout so it is easy to read and reproduce:

```text
ex_<number>_<name>/
├── design.sv          # The design (DUT)
├── tb.sv              # Self-checking testbench
├── wave.do            # Saved wave window setup
├── README.md          # Objective, results, what I learned (copy from templates/)
└── images/
    ├── waveform.png
    └── schematic.png
```

Guidelines for the images:

- Run the simulation first so signals show real values, not `X` or `z`.
- Crop tightly, save as PNG, and keep each file under a few hundred KB.
- Name files by content, for example `alu_waveform_overflow.png`.
- Embed them in the exercise README with relative paths:

```markdown
![ALU waveform](images/waveform.png)
```

---

## Progress

| Chapter | Status |
|---------|--------|
| 01 Basics | In progress |
| 02 Design | Not started |
| 03 Interfaces | Not started |
| 04 Verification | Not started |
| 05 Assertions | Not started |
| 06 Coverage | Not started |
| 07 UVM | Not started |
| Projects | Not started |

Detailed exercise tracking is in [EXERCISES.md](EXERCISES.md).

---

## Resources

- [ChipVerify: SystemVerilog Tutorial](https://www.chipverify.com/systemverilog/systemverilog-tutorial)
- [ChipVerify: UVM Tutorial](https://www.chipverify.com/uvm/uvm-tutorial)
- Siemens EDA QuestaSim documentation (available from the Help menu inside QuestaSim)
- IEEE 1800: SystemVerilog Language Reference Manual

---

## Author

**Asiedu Seth Osei**
GitHub: [@asieducodes](https://github.com/asieducodes)

---

*This repository is for learning purposes. Contributions and suggestions are welcome.*