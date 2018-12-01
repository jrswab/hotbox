echo 'Enter version number:'
read version
docker image build --tag jrswab/hotbox --tag jrswab/hotbox:$version .
