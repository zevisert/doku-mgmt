#!/bin/bash
if /usr/bin/pgrep gitlab.*runner; then
  exit 0
fi

exit 1
