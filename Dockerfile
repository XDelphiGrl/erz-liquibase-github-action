FROM openjdk:11-jre-slim-buster

# Install GNUPG for package vefification and WGET for file download
RUN apt-get update \
    && apt-get -y install gnupg wget \
    && rm -rf /var/lib/apt/lists/*

# Add the liquibase user and step in the directory
RUN addgroup --gid 1001 liquibase
RUN adduser --disabled-password --uid 1001 --ingroup liquibase liquibase

# Make /liquibase directory and change owner to liquibase
RUN mkdir /liquibase && chown liquibase /liquibase
WORKDIR /liquibase

#Symbolic link will be broken until later
RUN ln -s /liquibase/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh \
  && ln -s /liquibase/docker-entrypoint.sh /docker-entrypoint.sh \
  && ln -s /liquibase/liquibase /usr/local/bin/liquibase

# Change to the liquibase user
USER liquibase

# Latest Liquibase Release Version
ARG LIQUIBASE_VERSION=liquibase-4.3.0-DAT-5700-SNAPSHOT

# Download, verify, extract
RUN set -x \
  && wget --auth-no-challenge --user=XDelphiGrl --password=118016e91f23b6d523e1bf0bea0268155b "https://jenkins.datical.net/job/liquibase-pro/job/DAT-5700/13/artifact/liquibase/liquibase-dist/target/liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz" \
  && echo "liquibase-liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz" \
  && tar -xzf liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz \
  && rm liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz


COPY --chown=liquibase:liquibase docker-entrypoint.sh /liquibase/
COPY --chown=liquibase:liquibase liquibase.docker.properties /liquibase/

RUN chmod 0755 /liquibase/docker-entrypoint.sh

VOLUME /liquibase/classpath
VOLUME /liquibase/changelog

ENTRYPOINT ["/liquibase/docker-entrypoint.sh"]
CMD ["--help"]
CMD ["--version"]

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]