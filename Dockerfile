FROM liquibase/liquibase-4.3.0-DAT-5700-SNAPSHOT

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]