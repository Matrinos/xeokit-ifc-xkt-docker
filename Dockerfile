# The docker image for Viewing an IFC Model with xeokit
# https://www.notion.so/Viewing-an-IFC-Model-with-xeokit-c373e48bc4094ff5b6e5c5700ff580ee
#xeokit-metadata is on .netcore
FROM mcr.microsoft.com/dotnet/runtime:3.1 as builder

RUN apt-get update 
RUN apt-get install -y tar wget unzip npm

RUN wget -q -O IfcConvert-v0.6.0-517b819-linux64.zip \
https://s3.amazonaws.com/ifcopenshell-builds/IfcConvert-v0.6.0-517b819-linux64.zip \
&& unzip IfcConvert-v0.6.0-517b819-linux64.zip -d /usr/local/bin

RUN wget -q -O COLLADA2GLTF-v2.1.5-linux.zip \
https://github.com/KhronosGroup/COLLADA2GLTF/releases/download/v2.1.5/COLLADA2GLTF-v2.1.5-linux.zip \
&& mkdir COLLADA2GLTF && unzip COLLADA2GLTF-v2.1.5-linux.zip -d COLLADA2GLTF \
&& ln -s /COLLADA2GLTF/COLLADA2GLTF-bin /usr/local/bin/COLLADA2GLTF-bin

RUN wget -qO- https://github.com/bimspot/xeokit-metadata/releases/download/1.0.0/xeokit-metadata-linux-x64.tar.gz \
 |  tar -zxvf - \
&& ln -s /xeokit-metadata-linux-x64/xeokit-metadata /usr/local/bin/xeokit-metadata

RUN npm i -g @xeokit/xeokit-gltf-to-xkt
