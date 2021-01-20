FROM alpine:latest
LABEL authors "jasperhale <ljy087621@gmail.com>"

ENV VERSION v1.7-rc4
ENV OVERTURE_HOME="/home/overture"
ENV DATA_DIR="${OVERTURE_HOME}/data"
ENV TMP_DIR="${OVERTURE_HOME}/tmp"

RUN echo "export DATA_DIR=${DATA_DIR}" >> /etc/profile  \
    && echo "export OVERTURE_HOME=${OVERTURE_HOME}" >> /etc/profile

COPY getfilter.sh /getfilter.sh
COPY start.sh  /start.sh

RUN set -xe  \
    && apk add --no-cache unzip curl  \
    && mkdir -p "$OVERTURE_HOME" "$DATA_DIR"  "$TMP_DIR" \
    && cd  "$OVERTURE_HOME"  \
    && curl -fsSLO --compressed "https://github.com/shawn1m/overture/releases/download/${VERSION}/overture-linux-amd64.zip"  \
    && unzip -o "overture-linux-amd64.zip" -d "$TMP_DIR"  \
    && mv "$TMP_DIR/overture-linux-amd64" "$OVERTURE_HOME/overture"  \
    && rm -rf "overture-linux-amd64.zip"  "${TMP_DIR}"\
    && chmod a+x /getfilter.sh  \
    && sh /getfilter.sh  \
    && chmod a+x /start.sh  \
    &&  echo '0 2 * * *  sh  /start.sh'>>/var/spool/cron/crontabs/root  
#    && apk del unzip curl 

COPY config.json "$OVERTURE_HOME/config.yml"
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

EXPOSE 53
VOLUME "$DATA_DIR"

ENTRYPOINT [ "/entrypoint.sh" ]