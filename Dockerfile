FROM xdelphigrl/docker:v3.4

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]