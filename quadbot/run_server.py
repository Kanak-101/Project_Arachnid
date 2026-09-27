#!/usr/bin/env python3
"""Fixed entry point for Project Arachnid (Quadbot) Server.

Runs the FastAPI server directly from the workspace source tree so that any
modifications made to code, configs, or templates take immediate effect
without having to rebuild packages, rerun setup scripts, or restart system services.
"""
import os
import sys
from pathlib import Path

# Add project root directory to sys.path
ROOT = Path(__file__).resolve().parent
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

# Always run in the quadbot workspace root
os.chdir(str(ROOT))

from quadbot.server import main

if __name__ == "__main__":
    if "--mode" not in sys.argv:
        sys.argv.extend(["--mode", "rest"])
    main()
