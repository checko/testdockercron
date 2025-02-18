# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Install cron
RUN apt-get update && apt-get install -y cron

# Add your script to the Docker image
ADD renew.sh /usr/local/bin/renew.sh

# Give execution rights on the cron job
RUN chmod +x /usr/local/bin/renew.sh

# Create the cron job
RUN echo "* * * * * /usr/local/bin/renew.sh" > /etc/cron.d/my-cron-job

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/my-cron-job

# Apply the cron job
RUN crontab /etc/cron.d/my-cron-job

# Create the log file to be able to run tail
RUN touch /var/log/renew.log

# Run the command on container startup
CMD cron && tail -f /var/log/renew.log
