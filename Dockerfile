FROM docker.pkg.github.com/xdelphigrl/docker/erz-liquibase-docker:dat-5700

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]