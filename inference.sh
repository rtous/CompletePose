set -x

if [ $# -eq 0 ]
then
    echo "No arguments supplied"
    echo "USAGE: ./inference.sh DATASET_CONFIGURATION_FILE.sh DATASET_CONFIGURATION_FILE.sh [0/1]"
    echo "The optional param 0/1 signals laptop/office"
else
	######################
	if [ $# -eq 3 ]
	then
		SETUP=$3
	else
		SETUP=0 #0=laptop, 1=office
	fi
	######################
	if [ $SETUP -eq 0 ]
	then   
	    #DATASET_ORIGINAL="/Volumes/ElementsDat/pose/H36M/H36M"
	    DATASET_ORIGINAL="data/H36M"
	    #DATASET_ORIGINAL="/Volumes/ElementsDat/pose/H36M/ECCV2018/ECCV18OD_no_sufix"
	else
	    DATASET_ORIGINAL="/mnt/f/datasets/pose/H36M/H36M"
	    #DATASET_ORIGINAL="/Volumes/ElementsDat/pose/H36M/ECCV2018/ECCV18OD_no_sufix"
	fi
	######################

	source $1
	source $2
	FROZEN_KEYPOINTS=$4
	echo "FROZEN_KEYPOINTS="$FROZEN_KEYPOINTS
	if [ $FROZEN_KEYPOINTS -eq 0 ]
	then  
		OUTPUTPATH="data/output/"$MODEL_NAME"_"$DATASET_NAME
		MODELPATH=$OUTPUTPATH"/model/"$MODELFILE
	else
		OUTPUTPATH="data/output/"$MODEL_NAME"_"$DATASET_NAME
		MODELPATH="frozen_checkpoints/"$MODEL_NAME"_"$DATASET_NAME"/"$MODELFILE
	fi

	echo "MODELPATH="$MODELPATH

	python inference.py $DATASET_CROPPED $DATASET_ORIGINAL $OUTPUTPATH $DATASET_CHARADE $DATASET_CHARADE_IMAGES $DATASET_TEST $DATASET_TEST_IMAGES $MODELPATH $MODEL $ONLY15 $BODY_MODEL $NORMALIZATION $KEYPOINT_RESTORATION $NZ
fi

