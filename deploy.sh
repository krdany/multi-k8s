docker build -t krdanny/multi-client:latest -t krdanny/multi-client:$SHA -f ./client/Dockerfile ./client

docker build -t krdanny/multi-server:latest -t krdanny/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t krdanny/multi-worker:latest -t krdanny/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push krdanny/multi-client:latest
docker push krdanny/multi-server:latest
docker push krdanny/multi-worker:latest

docker push krdanny/multi-client:$SHA
docker push krdanny/multi-server:$SHA
docker push krdanny/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=krdanny/multi-server:$SHA
kubectl set image deployments/client-deployment client=krdanny/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=krdanny/multi-worker:$SHA

