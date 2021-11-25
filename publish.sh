#!/bin/bash

GM_VERSION=1.3.36
LAYER_NAME='graphicsmagick'

REGIONS='
eu-west-1
'

region=eu-west-1

PROFILE='tfg'

for region in $REGIONS; do
  aws lambda add-layer-version-permission --region $region --layer-name $LAYER_NAME \
    --statement-id sid1 --action lambda:GetLayerVersion --principal '*' \
    --version-number $(aws lambda publish-layer-version --region $region --layer-name $LAYER_NAME --zip-file fileb://layer.zip \
      --description "GraphicsMagick ${GM_VERSION} binaries" --query Version --output text --profile $PROFILE) --profile $PROFILE
done
