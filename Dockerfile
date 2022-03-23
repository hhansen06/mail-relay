FROM alpine:3
MAINTAINER Henrik Hansen <hhansen06@googlemail.com>

RUN apk add --no-cache postfix postfix-pcre py-pip
RUN pip install j2cli

# Add files
ADD conf /root/conf

# Runner
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

# Declare
EXPOSE 25

RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf
CMD ["/root/run.sh"]
