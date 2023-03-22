# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/540ProjectFRe/project_FinalPRe/project_FinalPRe.cache/wt [current_project]
set_property parent.project_path D:/540ProjectFRe/project_FinalPRe/project_FinalPRe.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.3 [current_project]
set_property ip_output_repo d:/540ProjectFRe/project_FinalPRe/project_FinalPRe.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
set_property include_dirs {
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/include
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/include
} [current_fileset]
add_files D:/540ProjectFRe/mycoefile_starry.coe
read_verilog {
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/common_defines.vh
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/gpio/gpio_defines.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/ptc/ptc_defines.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_params.vh
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/WishboneInterconnect/wb_intercon.vh
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/axi_intercon.vh
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_defines.v
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/include/axi/assign.svh
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/include/axi/typedef.svh
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/include/common_cells/registers.svh
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/global.h
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/pic_map_auto.h
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/build.h
}
set_property is_global_include true [get_files D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/common_defines.vh]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/gpio/gpio_defines.v]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/ptc/ptc_defines.v]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_defines.v]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/include/axi/assign.svh]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/include/axi/typedef.svh]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/include/common_cells/registers.svh]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/global.h]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/pic_map_auto.h]
set_property file_type "Verilog Header" [get_files D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/build.h]
read_mem D:/540ProjectFRe/src/SweRVolfSoC/BootROM/sw/boot_main.mem
read_verilog -library xil_defaultlib -sv {
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/cf_math_pkg.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/addr_decode.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/alienA.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/alienB.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/alienC.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_pkg.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_atop_filter.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_cdc.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_demux.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_err_slv.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_id_prepend.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/axi_intercon.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_intf.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_mux.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiInterconnect/pulp-platform.org__axi_0.25.0/src/axi_xbar.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/barriers.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lib/beh_lib.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/binary_to_gray.sv
  D:/540ProjectFRe/src/OtherSources/bscan_tap.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/btn/btn_top.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/cdc_fifo_gray.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/counter.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dbg/dbg.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/include/swerv_types.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dec/dec.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dec/dec_decode_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dec/dec_gpr_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dec/dec_ib_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dec/dec_tlu_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dec/dec_trigger.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/delta_counter.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/dma/dma_ctrl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/exu/exu.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/exu/exu_alu_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/exu/exu_div_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/exu/exu_mul_ctl.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/deprecated/fifo_v2.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/fifo_v3.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/gray_to_binary.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu_aln_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu_bp_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu_compress_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu_ic_mem.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu_ifc_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/ifu/ifu_mem_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/loser.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_addrcheck.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_bus_buffer.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_bus_intf.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_clkdomain.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_dccm_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_dccm_mem.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_ecc.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_lsc_ctl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_stbuf.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lsu/lsu_trigger.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/lzc.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/mem.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/lib/mem_lib.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/pic/pic_ctrl.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/player_module.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/rr_arb_tree.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/spill_register.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/stream_register.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/swerv.sv
  D:/540ProjectFRe/src/SweRVolfSoC/SweRVEh1CoreComplex/swerv_wrapper_dmi.sv
  D:/540ProjectFRe/src/OtherSources/pulp-platform.org__common_cells_1.20.0/src/sync.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/vga_top.sv
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/vga/winner.sv
  D:/540ProjectFRe/src/rvfpganexys.sv
}
read_verilog -library xil_defaultlib {
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/AxiToWb/axi2wb.v
  D:/540ProjectFRe/src/OtherSources/clk_gen_nexys.v
  D:/540ProjectFRe/src/SweRVolfSoC/BootROM/dpram64.v
  D:/540ProjectFRe/src/OtherSources/dtg.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/spi/fifo4.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/gpio/gpio_top.v
  D:/540ProjectFRe/src/LiteDRAM/litedram_core.v
  D:/540ProjectFRe/src/LiteDRAM/litedram_top.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/ptc/ptc_top.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/raminfr.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_alu.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_bufreg.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_csr.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_ctrl.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_decode.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_mem_if.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_rf_if.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_rf_ram.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_rf_ram_if.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_rf_top.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_shift.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_state.v
  D:/540ProjectFRe/src/LiteDRAM/serv_1.0.2/rtl/serv_top.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/spi/simple_spi_top.v
  D:/540ProjectFRe/src/SweRVolfSoC/swervolf_core.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/SystemController/swervolf_syscon.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_receiver.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_regs.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_rfifo.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_sync_flops.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_tfifo.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_top.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_transmitter.v
  D:/540ProjectFRe/src/SweRVolfSoC/Peripherals/uart/uart_wb.v
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/WishboneInterconnect/wb_intercon.v
  D:/540ProjectFRe/src/SweRVolfSoC/BootROM/wb_mem_wrapper.v
  D:/540ProjectFRe/src/SweRVolfSoC/Interconnect/WishboneInterconnect/wb_intercon_1.2.2-r1/wb_mux.v
}
read_ip -quiet D:/540ProjectFRe/project_FinalPRe/project_FinalPRe.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all d:/540ProjectFRe/project_FinalPRe/project_FinalPRe.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/540ProjectFRe/project_FinalPRe/project_FinalPRe.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all d:/540ProjectFRe/project_FinalPRe/project_FinalPRe.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]

read_ip -quiet D:/540ProjectFRe/project_FinalPRe/project_FinalPRe.srcs/sources_1/ip/image_ram/image_ram.xci
set_property used_in_implementation false [get_files -all d:/540ProjectFRe/project_FinalPRe/project_FinalPRe.srcs/sources_1/ip/image_ram/image_ram_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/540ProjectFRe/src/rvfpganexys.xdc
set_property used_in_implementation false [get_files D:/540ProjectFRe/src/rvfpganexys.xdc]

read_xdc D:/540ProjectFRe/src/LiteDRAM/liteDRAM.xdc
set_property used_in_implementation false [get_files D:/540ProjectFRe/src/LiteDRAM/liteDRAM.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top rvfpganexys -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef rvfpganexys.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file rvfpganexys_utilization_synth.rpt -pb rvfpganexys_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
