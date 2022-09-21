FROM alpine

ARG TARGETARCH
ARG TARGETOS
ARG URL

RUN case "$TARGETOS" in \
      "linux") ;; \
      *) echo "ERROR: Unsupported OS: ${TARGETOS}"; exit 1 ;; \
    esac && \
    case "$TARGETARCH" in \
      "amd64") smartdns_variant="smartdns-x86_64" ;; \
      "arm64") smartdns_variant="smartdns-aarch64" ;; \
      *) echo "ERROR: Unsupported CPU architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    wget "${URL}/$smartdns_variant" -O /usr/sbin/smartdns && \
    chmod +x /usr/sbin/smartdns

EXPOSE 53/udp

VOLUME "/etc/smartdns/"

HEALTHCHECK CMD ["pidof", "smartdns"]
CMD ["/usr/sbin/smartdns", "-f"]
