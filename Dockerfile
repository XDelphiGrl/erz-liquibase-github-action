FROM liquibase/liquibase:4.12

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
