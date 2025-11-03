#!/bin/bash

src="work/58/6b0b6350c8736725382521133fadaf/20250909_MiSeq-Yoda_BCL/Data"
dst="test_1pct_BCL/Data"

mkdir -p "$dst/Intensities/BaseCalls"

# Copy only the first few tiles (adjust the number as you like)
find "$src/Intensities/BaseCalls" -type f -name '*_1101_*' -exec cp --parents {} "$dst" \;

# Also copy RunInfo.xml, RunParameters.xml, and other metadata needed by bcl-convert
cp "$src"/../RunInfo.xml "$dst"/..
cp "$src"/../RunParameters.xml "$dst"/.. 2>/dev/null || true
