MODEL_NAME="CGAN"
MODEL="models_CGAN" #models models_mirror models_simple models_AE
NORMALIZATION="center_scale" #"center_scale", "basic", "none" 
KEYPOINT_RESTORATION=1 #the keypoints present in the incomplete input are restored in the generated output
#LEN_BUFFER_ORIGINALS=65536 #1000 65536
CROPPED_VARIATIONS=1 #1 (defalut) 0 to learn to copy
NZ=100 #32 #100 #100 #10 #0
DISCARDINCOMPLETEPOSES=1 #1
TRAINSPLIT=1 #0.8
PIXELLOSS_WEIGHT=0 #It's a GAN

#INFERENCE
MODELFILE="model_epoch20_batch0.pt"



