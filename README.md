# hacl

This repository contains code used to train a CNN to label the hippocampus and amygdala on whole brain 700 µm isotropic 7T MP2RAGE MRI.
No MRI scans are included here; the MRI data and output from the CNN can be found at: https://sites.google.com/site/hpardoe/hacl.
We used the DeepMedic framework for this study, so if you want to train your own CNN or perhaps use the models provided in this repository you will need to install the software described here: https://github.com/deepmedic/deepmedic. Note you will need a computer with a recent GPU; preferably you will have access to a GPU-equipped high performance compute cluster.

The repository also contains scripts used to analyse dice overlaps & CNN-derived volumes in the hipp_amyg_analysis... directory; these scripts are written in R

Please get in touch if you have any questions, heath.pardoe@nyulangone.org

