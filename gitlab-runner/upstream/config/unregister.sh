#!/bin/bash

# Unregister the runners
if ! /entrypoint unregister --all-runners; then
  exit 1
fi

exit 0
