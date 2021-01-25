FROM daticalerzsebet/docker:latest

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]