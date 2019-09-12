if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xdc') == -1

" Vim syntax file
" Language:     XDC - Xilinx Design Constraints
" Author:       Amal Khailtash <amal.khailtash@gmail.com>
" Maintainer:   Amal Khailtash <amal.khailtash@gmail.com>
" Last Change:  Tue, Oct 09, 2012  7:46:15 PM
" Credits:      Based on SDC Vim syntax file
" Version:      1.2
" Revision Comments:
"   Amal Khailtash <amal.khailtash@gmail.com> - Tue, Oct 09, 2012  7:46:15 PM
"     1.2 - Added property values and constants
"     1.1 - Cleanup
"     1.0 - Initial revision

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Read the TCL syntax to start with
runtime! syntax/tcl.vim

" ----------------------------------------------------------------------------------------------------------------------
" SDC-specific keywords
" ----------------------------------------------------------------------------------------------------------------------
" Operating Conditions
syntax keyword sdcOperatingConditions                  set_operating_conditions

" System Interface
syntax keyword sdcSystemInterface                      set_load

" Timing Constraints
syntax keyword sdcTimingConstraints                    create_clock create_generated_clock group_path
syntax keyword sdcTimingConstraints                    set_clock_groups set_clock_latency set_clock_sense
syntax keyword sdcTimingConstraints                    set_clock_uncertainty set_data_check set_disable_timing
syntax keyword sdcTimingConstraints                    set_input_delay set_max_time_borrow set_output_delay
syntax keyword sdcTimingConstraints                    set_propagated_clock

" Timing Exceptions
syntax keyword sdcTimingExceptions                     set_false_path set_max_delay set_min_delay set_multicycle_path

" Logic Assignments
syntax keyword sdcLogicAssignments                     set_case_analysis set_logic_dc set_logic_one set_logic_zero

" Design Object Access Commands
syntax keyword sdcObjectAccessCommands                 all_clocks all_fanin all_fanout all_inputs all_outputs
syntax keyword sdcObjectAccessCommands                 all_registers current_design get_cells get_clocks get_nets
syntax keyword sdcObjectAccessCommands                 get_pins get_ports get_timing_arcs get_timing_paths

" General Purpose Commands
syntax keyword sdcGeneralPurposeCommands               current_instance set_hierarchy_separator set_units

" ----------------------------------------------------------------------------------------------------------------------
" Unsupported SDC Commands
" ----------------------------------------------------------------------------------------------------------------------
" Unsupported
syntax keyword sdcCollection_Unsupported               foreach_in_collection

" Wire Load Models
syntax keyword sdcWireLoadModels_Unsupported           set_wire_load_min_block_size set_wire_load_mode
syntax keyword sdcWireLoadModels_Unsupported           set_wire_load_model set_wire_load_selection_group

" System Interface
syntax keyword sdcSystemInterface_Unsupported          set_drive set_driving_cell set_fanout_load
syntax keyword sdcSystemInterface_Unsupported          set_input_transition set_port_fanout_number

" Design Rule Constraints
syntax keyword sdcDesignRuleConstraints_Unsupported    set_max_capacitance set_min_capacitance set_max_fanout
syntax keyword sdcDesignRuleConstraints_Unsupported    set_max_transition

" Timing Constraints
syntax keyword sdcTimingConstraints_Unsupported        set_clock_gating_check
syntax keyword sdcTimingConstraints_Unsupported        set_clock_transition
syntax keyword sdcTimingConstraints_Unsupported        set_ideal_latency set_ideal_network set_ideal_transition
syntax keyword sdcTimingConstraints_Unsupported        set_resistance set_timing_derate

" Area Constraints
syntax keyword sdcAreaConstraints_Unsupported          set_max_area

" Multivoltage and power optimization constraints
syntax keyword sdcMultivoltagePowerOpt_Unsupported     create_voltage_area set_level_shifter_strategy
syntax keyword sdcMultivoltagePowerOpt_Unsupported     set_level_shifter_threshold set_max_dynamic_power
syntax keyword sdcMultivoltagePowerOpt_Unsupported     set_max_leakage_power

" Altera Unsupported
syntax keyword sdcAltera_Unsupported                   create_timing_netlist update_timing_netlist

" ----------------------------------------------------------------------------------------------------------------------
" XDC-specific extension keywords
" ----------------------------------------------------------------------------------------------------------------------
" Operating Conditions
syntax keyword xdcOperatingConditions                  report_operating_conditions reset_operating_conditions

" Timing Constraints
syntax keyword xdcTimingConstraints                    set_input_jitter set_external_delay set_system_jitter

" Logic Assignments
syntax keyword xdcLogicAssignments                     set_logic_unconnected

" Design Object Access Commands
syntax keyword xdcObjectAccessCommands                 all_cpus all_dsps all_ffs all_hsios all_latches all_rams
syntax keyword xdcObjectAccessCommands                 get_generated_clocks get_iobanks get_package_pins
syntax keyword xdcObjectAccessCommands                 get_path_groups get_sites filter set_property

" General Purpose Commands
syntax keyword xdcGeneralPurposeCommands               get_hierarchy_separator

" Floorplanning Commands
syntax keyword xdcFloorplanCommands                    add_cells_to_pblock create_pblock delete_pblock get_pblocks
syntax keyword xdcFloorplanCommands                    remove_cells_from_pblock resize_pblock

" Power-related Commands
syntax keyword xdcPowerCommands                        set_default_switching_activity set_power_opt
syntax keyword xdcPowerCommands                        set_switching_activity

" Power-related Commands
syntax keyword xdcPinPlanningCommands                  set_package_pin_val

" ----------------------------------------------------------------------------------------------------------------------
" Constants
" ----------------------------------------------------------------------------------------------------------------------
syntax keyword xdcConstant                             NO YES FALSE TRUE DISABLE ENABLE NONE BACKBONE SLOW FAST DONTCARE
syntax keyword xdcConstant                             NORMAL HIGH IBUF IFD BOTH HALT CONTINUE CORRECT_AND_CONTINUE
syntax keyword xdcConstant                             CORRECT_AND_HALT PRE_COMPUTED FIRST_READBACK
syntax keyword xdcConstant                             DIFF_HSTL_I DIFF_HSTL_II DIFF_HSTL_II_18 DIFF_HSTL_II_DCI
syntax keyword xdcConstant                             DIFF_HSTL_II_DCI_18 DIFF_HSTL_II_T_DCI DIFF_HSTL_II_T_DCI_18
syntax keyword xdcConstant                             DIFF_HSTL_II__T_DCI DIFF_HSTL_I_18 DIFF_HSTL_I_DCI
syntax keyword xdcConstant                             DIFF_HSTL_I_DCI_18 DIFF_HSUL_12_DCI DIFF_SSTL12_DCI
syntax keyword xdcConstant                             DIFF_SSTL12_T_DCI DIFF_SSTL135 DIFF_SSTL135_DCI DIFF_SSTL135_R
syntax keyword xdcConstant                             DIFF_SSTL135_T_DCI DIFF_SSTL15 DIFF_SSTL15_DCI DIFF_SSTL15_R
syntax keyword xdcConstant                             DIFF_SSTL15_T_DCI DIFF_SSTL18_I DIFF_SSTL18_II DIFF_SSTL18_II_DCI
syntax keyword xdcConstant                             DIFF_SSTL18_II_T_DCI DIFF_SSTL18_I_DCI HSLVDCI_15 HSLVDCI_18 HSTL_I
syntax keyword xdcConstant                             HSTL_II HSTL_II_18 HSTL_II_DCI HSTL_II_DCI_18 HSTL_II_T_DCI
syntax keyword xdcConstant                             HSTL_II_T_DCI_18 HSTL_I_18 HSTL_I_DCI HSTL_I_DCI_18 HSUL_12_DCI
syntax keyword xdcConstant                             LVCMOS12 LVCMOS18 LVCMOS25 LVDCI_15 LVDCI_18 LVDCI_DV2_15 LVDS
syntax keyword xdcConstant                             LVDCI_DV2_18 SSTL12_DCI SSTL12_T_DCI SSTL135 SSTL135_DCI SSTL135_R
syntax keyword xdcConstant                             SSTL135_T_DCI SSTL15 SSTL15_DCI SSTL15_R SSTL15_T_DCI SSTL18_I
syntax keyword xdcConstant                             SSTL18_II SSTL18_II_DCI SSTL18_II_T_DCI SSTL18_I_DCI
syntax keyword xdcConstant                             TUNED_SPLIT UNTUNED_SPLIT_25 UNTUNED_SPLIT_40 UNTUNED_SPLIT_50
syntax keyword xdcConstant                             UNTUNED_SPLIT_60 UNTINED_SPLIT_75 TUNED UNTUNED_25 UNTUNED_50
syntax keyword xdcConstant                             UNTUNED_75

" ----------------------------------------------------------------------------------------------------------------------
" Properties
" ----------------------------------------------------------------------------------------------------------------------
syntax keyword xdcProperty                             ASYNC_REG BEL CLOCK_DEDICATED_ROUTE COMPATIBLE_CONFIG_MODES
syntax keyword xdcProperty                             DCI_CASCADE DIFF_TERM DONT_TOUCH DRIVE HIODELAY_GROUP HLUTNM IN_TERM
syntax keyword xdcProperty                             INTERNAL_VREF IOB IODELAY_GROUP IOSTANDARD KEEP_HIERARCHY KEEPER LOC
syntax keyword xdcProperty                             LUTNM MARK_DEBUG OUT_TERM PACKAGE_PIN POST_CRC POST_CRC_ACTION
syntax keyword xdcProperty                             POST_CRC_FREQ POST_CRC_INIT_FLAG POST_CRC_SOURCE PROHIBIT PULLDOWN
syntax keyword xdcProperty                             PULLUP SLEW VCCAUX_IO

" ----------------------------------------------------------------------------------------------------------------------
" Command Flags
" ----------------------------------------------------------------------------------------------------------------------
syntax match   xdcFlags                                "[[:space:]]-[[:alpha:]]*\>"

" ----------------------------------------------------------------------------------------------------------------------
" Define the default highlighting.
" ----------------------------------------------------------------------------------------------------------------------
highligh default link sdcOperatingConditions                  Operator
highligh default link sdcSystemInterface                      Operator
highligh default link sdcTimingConstraints                    Operator
highligh default link sdcTimingExceptions                     Operator
highligh default link sdcLogicAssignments                     Operator
highligh default link sdcObjectAccessCommands                 Operator
highligh default link sdcGeneralPurposeCommands               Operator

highligh default link sdcCollection_Unsupported               WarningMsg
highligh default link sdcWireLoadModels_Unsupported           WarningMsg
highligh default link sdcSystemInterface_Unsupported          WarningMsg
highligh default link sdcDesignRuleConstraints_Unsupported    WarningMsg
highligh default link sdcTimingConstraints_Unsupported        WarningMsg
highligh default link sdcAreaConstraints_Unsupported          WarningMsg
highligh default link sdcMultivoltagePowerOpt_Unsupported     WarningMsg
highligh default link sdcAltera_Unsupported                   WarningMsg

highligh default link xdcOperatingConditions                  Operator
highligh default link xdcTimingConstraints                    Operator
highligh default link xdcLogicAssignments                     Operator
highligh default link xdcObjectAccessCommands                 Operator
highligh default link xdcGeneralPurposeCommands               Operator
highligh default link xdcFloorplanCommands                    Operaror
highligh default link xdcPowerCommands                        Operaror
highligh default link xdcPinPlanningCommands                  Operaror

highligh default link xdcConstant                             Constant
highligh default link xdcProperty                             Type

highligh default link xdcFlags                                Special

let b:current_syntax = "xdc"

" vim: fileformat=unix tabstop=2 shiftwidth=2 expandtab

endif
