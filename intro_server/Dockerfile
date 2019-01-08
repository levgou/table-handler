FROM bigtruedata/sbt

RUN mkdir -p /app-src

COPY app/ /app-src
COPY conf/ /app-src
COPY project/ /app-src
COPY public/ /app-src

EXPOSE 9000

# CMD rm -f /dist/RUNNING_PID && /dist/bin/start -Dhttp.port=$PORT -Dplay.crypto.secret=secret
WORKDIR /app-src
CMD sbt 'run $PORT'
