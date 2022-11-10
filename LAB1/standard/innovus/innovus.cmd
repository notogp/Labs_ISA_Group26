#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Nov  9 13:35:40 2022                
#                                                     
#######################################################

#@(#)CDS: Innovus v20.11-s130_1 (64bit) 08/05/2020 15:53 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.11-s130_1 NR200802-2257/20_11-UB (database version 18.20.512) {superthreading v2.9}
#@(#)CDS: AAE 20.11-s008 (64bit) 08/05/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.11-s059_1 () Aug  2 2020 05:46:30 ( )
#@(#)CDS: SYNTECH 20.11-s028_1 () Aug  1 2020 06:14:27 ( )
#@(#)CDS: CPE v20.11-s013
#@(#)CDS: IQuantus/TQuantus 19.1.3-s260 (64bit) Thu May 28 10:57:28 PDT 2020 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell myfir
set init_verilog ../netlist/myfir.v
set init_lef_file /eda/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell myfir
set init_verilog ../netlist/myfir.v
set init_lef_file /eda/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
set init_mmmc_file mmm_design.tcl
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1.0 0.6 5.0 5.0 5.0 5.0
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top metal1 bottom metal1 left metal2 right metal2} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -timingEngine {}
setUsefulSkewMode -maxSkew false -noBoundary false -useCells {CLKBUF_X3 CLKBUF_X2 CLKBUF_X1 BUF_X32 BUF_X16 BUF_X8 BUF_X4 BUF_X2 BUF_X1 INV_X32 INV_X16 INV_X8 INV_X4 INV_X2 INV_X1} -maxAllowedDelay 1
setPlaceMode -reset
setPlaceMode -congEffort auto -timingDriven 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 0 -placeIOPins 1 -moduleAwareSpare 0 -preserveRouting 1 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0
setPlaceMode -fp false
place_design
gui_select -rect {117.40550 69.21600 112.73300 61.16000}
deselectAll
gui_select -rect {116.27800 66.47650 111.92750 64.22100}
deselectAll
zoomIn
zoomOut
zoomIn
gui_select -rect {79.11300 65.29450 79.00550 65.83150}
zoomBox -0.52850 29.70900 104.54800 77.54000
pan 64.38550 28.72100
zoomIn
zoomOut
zoomOut
pan -62.93200 25.37250
zoomIn
pan -16.04850 28.53150
zoomIn
selectInst mult_106_G7_U42
deselectAll
selectWire 24.0000 53.5850 24.0700 59.4650 2 mult_106_G7_n83
deselectAll
selectInst mult_106_G7_U48
deselectAll
selectWire 25.7100 45.9550 25.7800 57.6450 2 mult_106_G7_n197
zoomBox 14.95200 40.78150 71.98600 66.74350
pan -37.24550 23.84050
zoomBox -17.65900 40.41800 30.82050 62.48600
zoomBox -13.71900 41.80000 27.48850 60.55750
zoomBox -10.38850 43.04850 24.63750 58.99250
zoomBox -34.39350 31.32300 44.54850 67.25750
zoomBox -124.22350 -18.18250 122.02700 93.91100
zoomBox -369.96900 -102.83300 185.02050 149.79900
pan 131.82250 296.17000
zoomBox -62.39450 20.25950 146.92050 115.54000
zoomBox -83.91750 11.26400 162.33550 123.35850
pan -0.74000 88.22150
zoomBox -110.52750 -6.25300 179.18200 125.62300
pan 6.44550 102.00950
deselectAll
gui_select -rect {118.73150 104.19500 109.84650 96.70400}
deselectAll
setDesignMode -process 45
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -preCTS
set_ccopt_property target_max_trans 0.08
set_ccopt_property target_skew 0.5
create_ccopt_clock_tree -name MY_CLK -source -CLK
create_ccopt_clock_tree -name MY_CLK -source CLK
ccopt_design
report_ccopt_clock_trees
report_ccopt_skew_groups
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
getFillerMode -quiet
addFiller -cell FILLCELL_X1 FILLCELL_X8 FILLCELL_X4 FILLCELL_X32 FILLCELL_X2 FILLCELL_X16 -prefix FILLER
saveDesign myfir_innovus
saveDesign myfir_innovus
getDrawView
setDrawView fplan
win
dumpToGIF Snapshot/ss_myfir_snapshot.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF Snapshot/ss_myfir_snapshot.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF Snapshot/ss_myfir_snapshot.place.gif
checkPlace checkplace.ss.rpt
reset_parasitics
extractRC
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix myfir_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix myfir_postRoute -outDir timingReports
verifyConnectivity -type all -error 1000 -warning 50
getMultiCpuUsage -localCpu
get_verify_drc_mode -disable_rules -quiet
get_verify_drc_mode -quiet -area
get_verify_drc_mode -quiet -layer_range
get_verify_drc_mode -check_ndr_spacing -quiet
get_verify_drc_mode -check_only -quiet
get_verify_drc_mode -check_same_via_cell -quiet
get_verify_drc_mode -exclude_pg_net -quiet
get_verify_drc_mode -ignore_trial_route -quiet
get_verify_drc_mode -max_wrong_way_halo -quiet
get_verify_drc_mode -use_min_spacing_on_block_obs -quiet
get_verify_drc_mode -limit -quiet
set_verify_drc_mode -disable_rules {} -check_ndr_spacing auto -check_only default -check_same_via_cell false -exclude_pg_net false -ignore_trial_route false -ignore_cell_blockage false -use_min_spacing_on_block_obs auto -report myfir.drc.rpt -limit 1000
verify_drc
set_verify_drc_mode -area {0 0 0 0}
reportGateCount -level 5 -limit 100 -outfile myfir.gateCount
saveNetlist myfir.v
saveNetlist myfir_post_route.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network myfir_post_route.sdf
write_sdf -ideal_clock_network -recompute_delay_calc myfir_post_route.sdf
report_area
report_area > report_area_post_route.txt
