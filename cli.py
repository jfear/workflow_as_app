#! /usr/bin/env python
from pathlib import Path
from subprocess import run

import typer


def main(config_file: Path):
    run(f"snakemake -p --cores 1 --configfile {config_file}", shell=True)

if __name__ == "__main__":
    typer.run(main)
