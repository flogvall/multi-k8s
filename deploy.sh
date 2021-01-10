docker build -t erikflogvall/multi-client:latest -t erikflogvall/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t erikflogvall/multi-worker:latest -t erikflogvall/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t erikflogvall/multi-worker:latest -t erikflogvall/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push erikflogvall/multi-client:latest
docker push erikflogvall/multi-client:$GIT_SHA

docker push erikflogvall/multi-server:latest
docker push erikflogvall/multi-server:$GIT_SHA

docker push erikflogvall/multi-worker:latest
docker push erikflogvall/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=erikflogvall/multi-client:$GIT_SHA
kubectl set image deployment/server-deployment server=erikflogvall/multi-server:$GIT_SHA
kubectl set image deployment/worker-deployment worker=erikflogvall/multi-worker:$GIT_SHA
