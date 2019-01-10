
# Server <img src="https://img.icons8.com/color/48/000000/docker.png" width="40"/> <img src="https://cdn.iconscout.com/icon/free/png-256/scala-226059.png" width="35"/> <img src="https://cdn-images-1.medium.com/max/1600/1*N0AUKlttflxzr8Ij-DfC7Q.png" width="60"/> <img src="https://img.icons8.com/color/1600/mongodb.png" width="40"/>


## Quick Setup
1. Install `docker` on your local machine
2. Install `docker-compose` on your local machine
3. `git pull https://github.com/levgou/table-handler.git`
4. `cd` the created folder
5. (`sudo`) `docker-compose up --build`
6. Wait a while
7. Server should be up and listening for http on 9000

## Developing with docker:
If you want the app to be compiled from your local sources:  
   1. Uncomment the `volumes`  section in `docker-compose.yaml`  
   2. Visit Stage 5. of Quick Setup  
   3. Intelij the local directory - 
      and see the changes reflected inside the container
