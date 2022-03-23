Postfix Mail Relay
======================

Contains:

* Postfix, running in a simple relay mode
* RSyslog

Processes are managed by supervisord, including cronjobs

The container provides a simple proxy relay for environments like Amazon VPC where you may have private servers with no Internet connection
and therefore with no access to external mail relays (e.g. Amazon SES, SendGrid and others). You need to supply the container with your 
external mail relay address and credentials. The configuration is tested with Amazon SES.


Exports
-------

* Postfix on `25`

Variables
---------

* `MY_DOMAIN`: DNS name for this relay container (usually the same as the Docker's hostname)
* `MY_NETWORKS=192.168.0.0/16 172.16.0.0/12 10.0.0.0/8`: Network (or a list of networks) to accept mail from


Example
-------

Launch Postfix container:

    $ docker run -d -h relay.example.com --name="mailrelay" -e SMTP_LOGIN=myLogin -e SMTP_PASSWORD=myPassword -p 25:25 alterrebe/postfix-relay


Running with Docker Compose:

```yaml
version: "3.4"

services:
  smtp:
    image: alterrebe/postfix-relay
    environment:
      RELAY_HOST_NAME: smtp.example.com
      EXT_RELAY_HOST: "email-smtp.eu-west-1.amazonaws.com"
      EXT_RELAY_PORT: 587
      SMTP_LOGIN: "AKIA*********"
      SMTP_PASSWORD: "*********************************"
      USE_TLS: "yes"
      TLS_VERIFY: "may"
      RAW_CONFIG: |
        # custom config
        always_bcc = bcc@example.com
```
