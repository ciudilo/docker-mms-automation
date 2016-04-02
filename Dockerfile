FROM debian:wheezy

RUN apt-get update && apt-get install -y curl logrotate

ENV MMS_VERSION 3.4.0.190-1

# see https://mms.mongodb.com/settings/monitoring-agent
# click on "Ubuntu 12.04+"
RUN curl -sSL https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_latest_amd64.deb -o mms.deb \
	&& dpkg -i mms.deb \
	&& rm mms.deb

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

USER mongodb-mms
CMD ["mongodb-mms-automation-agent", "-conf", "/etc/mongodb-mms/automation-agent.config"]
