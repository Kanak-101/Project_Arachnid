"""Load / save the YAML robot config. Saving keeps a .bak of the previous file."""
import shutil
from pathlib import Path

import yaml


def load(path):
    with open(path, "r") as f:
        return yaml.safe_load(f)


def save(cfg, path):
    path = Path(path)
    if path.exists():
        shutil.copy(path, path.with_suffix(path.suffix + ".bak"))
    with open(path, "w") as f:
        yaml.safe_dump(cfg, f, sort_keys=False, default_flow_style=None)
