#!/bin/sh
rm -rf smoke/
docker rm hotbox

echo 'Enter version number:'
read -r version
docker image build --tag jrswab/hotbox --tag jrswab/hotbox:"$version" .
