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

RUN set -x \
  && wget -O liquibase-${LIQUIBASE_VERSION}.tar.gz "https://jenkins.datical.net/job/liquibase-pro/job/DAT-5700/13/artifact/liquibase/liquibase-dist/target/liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz \
  && echo "liquibase-liquibase-4.3.0-DAT-5700-SNAPSHOT.tar.gz" \
  && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz \

COPY --chown=liquibase:liquibase docker-entrypoint.sh /liquibase/
COPY --chown=liquibase:liquibase liquibase.docker.properties /liquibase/

RUN chmod 0755 /liquibase/docker-entrypoint.sh

VOLUME /liquibase/classpath
VOLUME /liquibase/changelog

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]
