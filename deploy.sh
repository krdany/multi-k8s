docker build -t krdanny/multi-client:latests -t krdanny/multi-client:$SHA -f ./client/Dockerfile ./client

docker build -t krdanny/multi-server:latests -t krdanny/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t krdanny/multi-worker:latests -t krdanny/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push krdanny/multi-client:latests
docker push krdanny/multi-server:latests
docker push krdanny/multi-worker:latests

docker push krdanny/multi-client:$SHA
docker push krdanny/multi-server:$SHA
docker push krdanny/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=krdanny/multi-server:$SHA
kubectl set image deployments/client-deployment server=krdanny/multi-client:$SHA
kubectl set image deployments/worker-deployment server=krdanny/multi-worker:$SHA

