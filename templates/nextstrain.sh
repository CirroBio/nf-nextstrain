#!/bin/bash

set -e

# Fetch the workflow specified by the user
echo "Cloning workflow ${params.workflow}"
git clone https://github.com/nextstrain/${params.workflow}

# Move the input files which have been staged by Nextflow
# into the data directory expected by the workflow
echo "Adding sequences and metadata to data directory"
mv custom.sequences.fasta ${params.workflow}/data/
mv custom.metadata.tsv ${params.workflow}/data/

# The build will be executed using the config file
# provided as input to the workflow
echo "Using config:"
cat configfile.yaml

# Execute the workflow
# Note: Using the ambient runtime because this command
# should already be run inside the Nextstrain Docker image
echo "Running the workflow"
nextstrain build \
    --ambient \
    --configfile configfile.yaml \
    ${params.workflow}
