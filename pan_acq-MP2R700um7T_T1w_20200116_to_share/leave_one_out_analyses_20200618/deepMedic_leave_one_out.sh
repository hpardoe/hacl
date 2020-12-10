#!/bin/bash
# leave one out deepmedic generator
DATA=/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/data
MODEL=/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/template_files/modelConfig.cfg

SUB=$1
mkdir $SUB
mkdir $SUB/model
mkdir $SUB/output
mkdir $SUB/test
mkdir $SUB/train

# model config file creation steps:
# 1. change modelName
MODELSTRING="deepMedic_mp2r_hipp_amyg_seg_"$SUB"_20200618"
MODELCFG="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/model/modelConfig.cfg"
OUTPUTSTRING="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/output"

TRAINCFG="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/train/trainConfig.cfg"
TRAINCHANNELS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/train/trainChannels_t1c.cfg"
TRAINGTLABELS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/train/trainGtLabels.cfg"
TRAINROIMASKS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/train/trainRoiMasks.cfg"

TESTCFG="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/test/testConfig.cfg"
TESTOUTPUT="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/test/output"
TESTCHANNELS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/test/testChannels_t1c.cfg"
TESTGTLABELS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/test/testGtLabels.cfg"
TESTROIMASKS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/test/testRoiMasks.cfg"
TESTNAMEPREDS="/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/"$SUB"/test/testNamesOfPredictions.cfg"

sed "s/deepMedic_mp2r_hipp_amyg_seg_20200116/$MODELSTRING/" $MODEL > .tmp_model
# 2. change folderForOutput
sed "s|/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/output|$OUTPUTSTRING|" .tmp_model > $MODELCFG

# create training files
# 1. trainChannels_t1c.cfg
find /gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/data -name "*_acq-MP2R700um7T_T1w_defaced_reorient_subtrMeanDivStd.nii.gz" | sort | grep -v $SUB > $SUB/train/trainChannels_t1c.cfg
# 2. trainConfig.cfg
# 2a. change session name
SESSIONNAME=trainSessionDm20200121_$SUB
sed "s/testSessionDm20200116/$SESSIONNAME/" /gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/template_files/trainConfig.cfg > .tmp_traincfg
# 2b. change folderForOutput
sed "s|/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/output|$OUTPUTSTRING|" .tmp_traincfg > $TRAINCFG
# 3. trainGtLabels.cfg
for f in $( cat $TRAINCHANNELS ); do DIR=$( dirname $f ); find $DIR -name "*_acq-MP2R700um7T_hipp_amyg_reorient.nii.gz"; done > $TRAINGTLABELS
# 4. trainROIMasks.cfg
for f in $( cat $TRAINCHANNELS ); do DIR=$( dirname $f ); find $DIR -name "*_acq-MP2R700um7T_T1w_defaced_reorient_brain_mask.nii.gz"; done > $TRAINROIMASKS

# create testing files
#1. testChannels_t1c.cfg
find /gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/data/$SUB -name "*_acq-MP2R700um7T_T1w_defaced_reorient_subtrMeanDivStd.nii.gz" > $TESTCHANNELS
# 2. testGtLabels.cfg
for f in $( cat $TESTCHANNELS ); do DIR=$( dirname $f ); find $DIR -name "*_hipp_amyg_reorient.nii.gz"; done > $TESTGTLABELS
# 3. testROIMasks.cfg
for f in $( cat $TESTCHANNELS ); do DIR=$( dirname $f ); find $DIR -name "*_acq-MP2R700um7T_T1w_defaced_reorient_brain_mask.nii.gz"; done > $TESTROIMASKS
# 4. testNamesOfPredictions.cfg
for f in $( cat $TESTCHANNELS ); do DIR=$( dirname $f); BASE=$( basename $f ); echo $BASE | sed 's/subtrMeanDivStd/subtrMeanDivStd_pred/'; done > $TESTNAMEPREDS
# 5. And finally, testConfig.cfg
sed "s|/gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/test/output|$TESTOUTPUT|" /gpfs/data/epilepsy/mri/hpardoe/hipp_amyg_seg_cnn_20200115/pan_acq-MP2R700um7T_T1w_20200116/leave_one_out_analyses_20200618/template_files/testConfig.cfg > $TESTCFG 
