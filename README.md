# docker-ibm-rlks
Rational License Key Server under supervisord in docker
Build
-----
docker build -t rlks:%version%  --build-arg ARTIFACT_DOWNLOAD_URL=%RLKS_MEDIA_URL% .

ARTIFACT_DOWNLOAD_URL must point to IBM_Rational_License_Key_Server_Linux_x86_ZIP.zip somwhere wget can download from

Run
---
docker run --name rlks -d -v %hostpath%:/usr/local/flexlm/licenses rlks:8.1.4

 %hostpath% must contain a file "server_license.lic" with the appropriate licensing keys/server info
