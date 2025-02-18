docker build -t my-cron-job .

docker run -d my-cron-job


docker exec -it <container_id_or_name> cat /var/log/renew.log

