RUN set -x \
  && wget -O liquibase-${LIQUIBASE_VERSION}.tar.gz "https://jenkins.datical.net/job/liquibase-pro/job/DAT-5700/13/artifact/liquibase/liquibase-dist/target/liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz \
  && echo liquibase-liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz" \
  && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz \

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
