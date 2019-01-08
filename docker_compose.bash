#!/bin/bash

rm -rf intro_server/dist/

cd intro_server
sbt dist
unzip -d dist target/universal/intro-1.0.zip
mv dist/*/* dist/ && rm dist/bin/*.bat && mv dist/bin/* dist/bin/start
cd ..

sudo docker-compose up --build