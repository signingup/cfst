#!/bin/bash
set -m

FILE="/cfst/start.sh"

if [ -f "$FILE" ]; then
  cp "$FILE" /usr/bin/start
  chmod +x /usr/bin/start && /usr/bin/start
fi

crond -f
fg %1
