#!/bin/bash
if /usr/bin/pgrep -f .*register; then
  exit 0
elif /usr/bin/pgrep gitlab.*runner; then
  exit 0
else
  exit 1
fi
