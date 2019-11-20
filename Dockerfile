FROM alephdata/followthemoney AS ftm

COPY data/ /source
ENV NEO4J_ADMIN_PATH=neo4j-admin
RUN mkdir -p /graph
RUN cat /source/* | ftm validate | ftm export-neo4j-bulk -o /graph -e entity -e name -e address -e identifier

FROM neo4j
COPY --chown=101:101 --from=ftm /graph /graph
WORKDIR /graph
RUN chmod +x ./neo4j_import.sh
RUN ./neo4j_import.sh && cp -R /data /ftmgraph
RUN chown -R 101:101 /ftmgraph
ENV NEO4J_AUTH=none
ENV NEO4J_ACCEPT_LICENSE_AGREEMENT=yes
ENV NEO4J_dbms_directories_data=/ftmgraph