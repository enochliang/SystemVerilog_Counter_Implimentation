# Convert core sources

set -e

LR_SYNTH_OUT_DIR="pre_map_design"

error () {
    echo >&2 "$@"
    exit 1
}

teelog () {
    tee "$LR_SYNTH_OUT_DIR/log/$1.log"
}


mkdir -p "$LR_SYNTH_OUT_DIR/generated"
mkdir -p "$LR_SYNTH_OUT_DIR/log"
mkdir -p "$LR_SYNTH_OUT_DIR/reports/timing"

for file in ./rtl/*.sv; do
  module=$(basename -s .sv "$file")

  # Skip packages
  if echo "$module" | grep -q '_pkg$'; then
      continue
  fi

  sv2v \
    -I./rtl \
    "$file" \
    > ./"$LR_SYNTH_OUT_DIR"/generated/"${module}".v

done

rm -f ./"$LR_SYNTH_OUT_DIR"/generated/tb.v

yosys -c ./tcl/yosys_run_synth.tcl |& teelog syn || {
    error "Failed to synthesize RTL with Yosys"
}
