FROM alpine

ARG URL

RUN case "$TARGETPLATFORM" in \
      "linux/amd64") smartdns_variant="smartdns-x86_64" ;; \
      "linux/arm64") smartdns_variant="smartdns-aarch64" ;; \
      *) echo "ERROR: Unsupported platform: ${TARGETPLATFORM}"; exit 1 ;; \
    esac && \
    wget "${URL}/$smartdns_variant" -O /usr/sbin/smartdns && \
    chmod +x /usr/sbin/smartdns

EXPOSE 53/udp

VOLUME "/etc/smartdns/"

HEALTHCHECK CMD ["pidof", "smartdns"]
CMD ["/usr/sbin/smartdns", "-f"]
