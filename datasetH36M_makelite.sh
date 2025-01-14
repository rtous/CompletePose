#EXAMPLE: ./datasetH36M_makelite.sh

#Assumes H36M 2D poses in data/H36M (see README.md)

SETUP=0 #0=laptop, 1=office

if [ $SETUP -eq 0 ]
then   
    DATASET_ORIGINAL="data/H36M"
    #DATASET_ORIGINAL="/Volumes/ElementsDat/pose/H36M/H36M"
    #DATASET_ORIGINAL="/Volumes/ElementsDat/pose/H36M/ECCV2018/ECCV18OD_no_sufix"
else
    DATASET_ORIGINAL="/mnt/f/datasets/pose/H36M/H36M"
    #DATASET_ORIGINAL="/Volumes/ElementsDat/pose/H36M/ECCV2018/ECCV18OD_no_sufix"
fi

OUTPUTPATH="data/TEST/H36Mtest_v2"
OUTPUTPATH_ORIGINAL="data/TEST/H36Mtest_original_v2"
MAX=1000

python util_makeLiteH36M.py $OUTPUTPATH $OUTPUTPATH_ORIGINAL $MAX $DATASET_ORIGINAL

