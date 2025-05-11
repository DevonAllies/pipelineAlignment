# pipelineAlignment

A Nextflow-based genomic alignment pipeline.

## 📦 Repository Structure
```
.
├── 1OrionPax.nf                # Main workflow file 1
├── 2Mirage.nf                  # Main workflow file 2
├── autobots.pbs                # PBS job script
├── megatron.config             # Pipeline configuration
├── modules/                    # Nextflow submodules
│   ├── local/                  # Custom processes
│   └── sampleSheets/           # Input CSVs
└── starscream.pbs              # PBS job script
```

## 🚀 Quick Start
1. Install dependencies:
   ```bash
   conda install -c bioconda nextflow
   ```

2. Run the pipeline:
   ```bash
   nextflow run 1OrionPax.nf -c megatron.config
   ```

## ⚙️ Configuration
Edit `megatron.config` for:
- Input/output paths
- Resource allocation (CPU/memory)
- Reference genomes

## 📝 Sample Sheets
Format your input CSV in `modules/sampleSheets/`:
```csv
sample,fastq
sample1,/path/to/reads_R1.fastq.gz
```

## 🤖 PBS Job Submission
```bash
qsub autobots.pbs
```

## 📌 Requirements
- Nextflow ≥22.04
- Java 8+
- Singularity/Docker (recommended)