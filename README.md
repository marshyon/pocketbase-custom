# Pocketbase Docker Image

rather than using the stock binary I wanted to see how easy it would be to create a custom pocketbase and have it serve files from 'pb_public', for example a react app

the Dockerfile uses a debian image to both build and serve the pocketbase app

I found that the alpine image failed to find the binary once built, probably due to some part of the binary that is created needing to use things that require glibc libraries and the like, which dont exist in the way they do in Debian, Ubuntu etc, so for now Debian will do.

## BUILD

build docker image with something like 

```
docker build -t pocketbase-cust:0.0.6 .
```

## RUN

run with something like 

```
run -d --name=pocketbase -p 8090:8090 -v $(pwd)/public:/pb_public -v $(pwd)/data:/pb_data pocketbase-cust:0.0.6
```

anything in `public` directory is served so creating a build directory from the react app directory can be copied to public and served from the root of the pocketbase site, for example

```
cd react-app
npm run build
sudo cp -r build/* ../public
```
