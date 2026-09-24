import os

folders = [
    "01_basics/arrays",
    "01_basics/data_types",
    "01_basics/procedural",
    "02_design/combinational",
    "02_design/sequential",
    "02_design/fsm",
    "03_interfaces/basic_interface",
    "03_interfaces/advanced_interface",
    "04_verification/01_classes",
    "04_verification/02_randomization",
    "04_verification/03_ipc",
    "05_assertions/immediate",
    "05_assertions/concurrent",
    "06_coverage/code_coverage",
    "06_coverage/functional_coverage",
    "07_uvm/components",
    "07_uvm/top",
    "projects/spi_controller",
    "projects/traffic_light",
    "sim",
    "scripts"
]

print("Creating project directories...")
for folder in folders:
    os.makedirs(folder, exist_ok=True)
    print(f" -> Created: {folder}")

print("\nSuccess! Your repository structure is perfectly initialized.")
