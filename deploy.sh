docker build -t aditya81070/multi-client:latest -t aditya81070/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aditya81070/multi-server:latest -t aditya81070/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aditya81070/multi-worker:latest -t aditya81070/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aditya81070/multi-client:latest
docker push aditya81070/multi-client:$SHA
docker push aditya81070/multi-server:latest
docker push aditya81070/multi-server:$SHA
docker push aditya81070/multi-worker:latest
docker push aditya81070/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aditya81070/multi-server:$SHA
kubectl set image deployments/client-deployment client=aditya81070/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aditya81070/multi-worker:$SHA