FROM openbankproject/obp-base
MAINTAINER OpenBankProject <contact@openbankproject.com> NovaSolutionsSystems <rgutierrez@novasolutionsystems.com>
EXPOSE 8080 8081 8082

# Clone all repositories
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/OBP-API.git
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/Social-Finance.git
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/API-Explorer.git
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/OBP-Docker.git

# Supervisor
WORKDIR /opt/OBP/OBP-Docker/full/supervisor
RUN cp *.conf /etc/supervisor/conf.d/
# /Supervisor

# Social Finance
WORKDIR /opt/OBP/OBP-Docker/full
#RUN cp lift_proto.db.h2.db /opt/OBP/OBP-API/ temporal
WORKDIR /opt/OBP/OBP-Docker/full/props
RUN cp Social-Finance.default.props /opt/OBP/Social-Finance/src/main/resources/props/default.props
WORKDIR /opt/OBP/Social-Finance/
COPY 8081run.sh ./run.sh
RUN mvn package -DskipTests
# /Social Finance

# API EXPLORER
WORKDIR /opt/OBP/OBP-Docker/full/props
RUN cp API-Explorer.default.props /opt/OBP/API-Explorer/src/main/resources/props/default.props
WORKDIR /opt/OBP/API-Explorer/
COPY 8082run.sh ./run.sh
RUN mvn package -DskipTests
# /API EXPLORER

# API
WORKDIR /opt/OBP/OBP-API/obp-api/src/main/resources/props
RUN mv sample.props.template default.props
WORKDIR /opt/OBP/OBP-API
COPY 8080run.sh ./run.sh
RUN ./mvn.sh install -pl .,obp-commons
#RUN ./mvn.sh jetty:run -pl obp-api
# /API

#Enviroments
ENV "OBP_API_HOSTNAME"=http://localhost:8080
ENV "OBP_BASE_URL_API_EXPLORER"=http://localhost:8082
ENV "OBP_BASE_URL_SOCIAL_FINANCE"=http://localhost:8081
ENV "OBP_WEBUI_API_EXPLORER_URL"=http://localhost:8082


## Run script
WORKDIR /usr/local/sbin/
COPY run_obp .
CMD /usr/local/sbin/run_obp

#run servers
WORKDIR /opt/OBP/API-Explorer
CMD sh run.sh
WORKDIR /opt/OBP/Social-Finance
CMD sh run.sh
WORKDIR /opt/OBP/OBP-API
CMD sh run.sh

#Bash
CMD ["/bin/bash"]

#Observaciones
# OBP_API
#  ./mvn.sh install -pl .,obp-commons
# Social Finance
#  mvn jetty:run -Djetty.port=8081
# API EXPLORER
#  mvn jetty:run -Djetty.port=8082
