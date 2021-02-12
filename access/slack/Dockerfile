FROM golang:1.14.15-buster

RUN update-ca-certificates
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 --output-file /usr/bin/jq

COPY . /source
WORKDIR /source
RUN make access-slack
COPY access/slack/build/teleport-slack /teleport-slack
RUN rm -r /source

CMD ["sh", "init.sh"]
