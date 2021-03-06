if {![info exists standalone] || $standalone} {
  # Read process files
  foreach libFile $::env(LIB_FILES) {
    read_liberty $libFile
  }
  read_lef $::env(OBJECTS_DIR)/merged_padded.lef

  # Read design files
  read_def $::env(RESULTS_DIR)/4_cts.def
}

set_wire_rc -layer $::env(WIRE_RC_LAYER)

#TODO - is this condition required
if {$::env(PLATFORM) == "gf14"} {
  fastroute -capacity_adjustment 0.15 \
    -output_file $::env(RESULTS_DIR)/route.guide \
    -min_routing_layer 2 \
    -max_routing_layer $::env(MAX_ROUTING_LAYER) \
    -unidirectional_routing true
} else {
  fastroute -capacity_adjustment 0.15 \
            -max_routing_layer $::env(MAX_ROUTING_LAYER) \
            -output_file $::env(RESULTS_DIR)/route.guide
}

if {![info exists standalone] || $standalone} {
  exit
}
