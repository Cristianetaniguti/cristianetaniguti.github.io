---
layout: post
title: Genotyping-by-Sequencing data SNP and dosage calling
sutitle: A practical guide for polyploid species
tags: [bash, Docker, WDL, molecular markers, GBS]
---

Here we use Docker/singularity containers to perform SNP calling with GATK. We also show how to run a Workflow Description Language (WDL) to perform the same analysis and also including freebayes for SNP calling.

Before start, it is important to highlight that all software here presented has several parameters that can be adjusted for each given scenario. Here, we will use the default settings, but for the best usage of each one of them, it is important to explore their specificity. So... use it carefully!

## What you will need to run this tutorial (only a subset of data is used)

* Linux system
* At least 4G RAM
* At least 7G HD
* Docker or singularity
* Internet connection

Access the tutorial [here](https://cristianetaniguti.github.io/tools2023/computational_support_day1.html)