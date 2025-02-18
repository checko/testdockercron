# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Install cron
RUN apk update && apk add --no-cache bash curl busybox-suid

# Add your script to the Docker image
ADD renew.sh /usr/local/bin/renew.sh

# Give execution rights on the cron job
RUN chmod +x /usr/local/bin/renew.sh

# Create the cron job
RUN echo "* * * * * /usr/local/bin/renew.sh" > /etc/crontabs/root

# Create the log file to be able to run tail
RUN touch /var/log/renew.log

# Run the command on container startup
CMD crond && tail -f /var/log/renew.log
