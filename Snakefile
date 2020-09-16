from snakemake.rules import expand
from random import randint

rule all:
    input:
        expand("/opt/workflow/level2_{idx}.txt", idx=range(config["count"]))
    output: "/output/results.txt"
    shell: "cat {input} > {output[0]}"


rule one:
    output: "/opt/workflow/level1_{idx}.txt"
    run:
        with open(output[0], "w") as fh:
            fh.write(f"{randint(0, 100):,}")

rule two:
    input: rules.one.output[0]
    output: "/opt/workflow/level2_{idx}.txt"
    run:
        with open(input[0]) as fin, open(output[0], "w") as fout:
            fout.write(f"{wildcards.idx}:{fin.read()}\n")
