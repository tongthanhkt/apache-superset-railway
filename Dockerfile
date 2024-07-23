FROM apache/superset:latest

USER root

RUN pip install mysqlclient
RUN pip install google
RUN pip install google-api-core
RUN pip install google.cloud.bigquery
RUN pip install google.cloud.storage
RUN pip install --upgrade google-api-python-client
RUN pip install sqlalchemy-bigquery
RUN pip install pybigquery

ENV ADMIN_USERNAME $ADMIN_USERNAME
ENV ADMIN_EMAIL $ADMIN_EMAIL
ENV ADMIN_PASSWORD $ADMIN_PASSWORD

COPY /config/superset_init.sh ./superset_init.sh
RUN chmod +x ./superset_init.sh

COPY /config/superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py
ENV SECRET_KEY $SECRET_KEY

USER superset

ENTRYPOINT [ "./superset_init.sh" ]
