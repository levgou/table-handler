FROM openjdk:8-jre

COPY dist /dist
EXPOSE 9000

CMD rm -f /dist/RUNNING_PID && /dist/bin/start -Dhttp.port=$PORT -Dplay.crypto.secret=secret
