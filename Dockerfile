FROM alpine

ARG URL

RUN wget ${URL} -O /usr/sbin/smartdns && \
    chmod +x /usr/sbin/smartdns

EXPOSE 53/udp

VOLUME "/etc/smartdns/"

HEALTHCHECK CMD ["pidof", "smartdns"]
CMD ["/usr/sbin/smartdns", "-f"]
