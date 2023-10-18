# nf-nextstrain
Nextflow workflow to run Nextstrain builds

Parameters:

- workflow: Nextstrain workflow to run (e.g. ncov)
- sequences: Path to FASTA file with genome sequences
- metadata: Path to TSV file with genome metadata
- configfile: Path to YAML file with workflow configuration
- auspice: Path to JSON file with auspice configuration
- output: Path to root of output directory (all outputs will start with the workflow name)

Runtime:

- cpus: Number of CPUs allocate for the entire workflow (default: 4)
- memory_gb: Number of GBs of RAM to allocate (default: 16)
- container: Docker container to run the entire workflow in (e.g. nextstrain/base:build-20230623T174208Z)
