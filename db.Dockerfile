FROM postgres:11.5-alpine
COPY dubbing.sql /docker-entrypoint-initdb.d/