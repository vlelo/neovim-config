local dap_cortex_debug = require('dap-cortex-debug')
table.insert(require('dap').configurations.c,
	dap_cortex_debug.openocd_config({
		name = "OpenOCD Zephyr NUCLEO_H723ZG",
		cwd = "/Users/vleo/Uni/Sem2/SAGE/imgonnakillmyself/zephyrproject",
		executable = "/Users/vleo/Uni/Sem2/SAGE/imgonnakillmyself/zephyrproject/build/zephyr/zephyr.elf",
		type = "cortex-debug",
		request = "launch",
		servertype = "openocd",
		toolchainPath = "/Users/vleo/.local/bin/arm-gnu-toolchain-12.2/bin",
		gdbPath = "/Users/vleo/.local/bin/arm-gnu-toolchain-12.2/bin/arm-none-eabi-gdb",
		configFiles = {
			"/Users/vleo/Uni/Sem2/SAGE/imgonnakillmyself/zephyrproject/zephyr/boards/arm/nucleo_h723zg/support/openocd.cfg"
		},
		gdbTarget = "localhost:3333",
		rttConfig = dap_cortex_debug.rtt_config(0),
		showDevDebugOutput = true,
	}))
-- {
-- 	name = "OpenOCD Zephyr Launch",
-- 	cwd = "/Users/vleo/Uni/Sem2/SAGE/imgonnakillmyself/zephyrproject",
-- 	MIMode = "gdb",
-- 	servertype = "openocd",
-- 	executable = "/Users/vleo/Uni/Sem2/SAGE/imgonnakillmyself/zephyrproject/build/zephyr/zephyr.elf",
-- 	debugServerPath = "openocd",
-- 	debugServerArgs = "-f interface/stlink-v2.cfg -c \"transport select hla_swd\" -f target/nrf52.cfg",
-- 	filterStderr = true,
-- 	miDebuggerPath = "gdb-multiarch",
-- 	customLaunchSetupCommands = {
-- 		{ text = "file /Users/vleo/Uni/Sem2/SAGE/imgonnakillmyself/zephyrproject/build/zephyr/zephyr.elf" },
-- 		{ text = "target remote localhost:3333" },
-- 		{ text = "monitor reset halt" },
-- 	},
-- },
