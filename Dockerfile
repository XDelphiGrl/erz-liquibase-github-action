FROM xdelphigrl/docker:3.4

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]