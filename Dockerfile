FROM openbankproject/obp-base
MAINTAINER OpenBankProject <contact@openbankproject.com> NovaSolutionsSystems <rgutierrez@novasolutionsystems.com>
EXPOSE 8080 8081 8082

# Instalando fuser Ex: fuser -n tcp 8080
RUN apt-get install psmisc

# Clone all repositories
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/OBP-API.git
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/Social-Finance.git
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/API-Explorer.git
RUN cd /opt/OBP/ && git clone https://github.com/OpenBankProject/OBP-Docker.git

# Supervisor
COPY *.conf /etc/supervisor/conf.d/
# /Supervisor

# Social Finance
WORKDIR /opt/OBP/OBP-Docker/full/props
RUN cp Social-Finance.default.props /opt/OBP/Social-Finance/src/main/resources/props/default.props
WORKDIR /opt/OBP/Social-Finance/
# /Social Finance

# API EXPLORER
WORKDIR /opt/OBP/OBP-Docker/full/props
RUN cp API-Explorer.default.props /opt/OBP/API-Explorer/src/main/resources/props/default.props
WORKDIR /opt/OBP/API-Explorer/
# /API EXPLORER

# API
WORKDIR /opt/OBP/OBP-API/obp-api/src/main/resources/props
COPY default.props .
WORKDIR /opt/OBP/OBP-API
# /API


#Enviroments
ENV "OBP_API_HOSTNAME"=http://localhost:8080 \
    "OBP_BASE_URL_API_EXPLORER"=http://localhost:8082 \
    "OBP_BASE_URL_SOCIAL_FINANCE"=http://localhost:8081 \
    "OBP_WEBUI_API_EXPLORER_URL"=http://localhost:8082 \
    "MAVEN_OPTS"="-Xmx1024m -Xms1024m -Xss2048k -XX:MaxMetaspaceSize=1024m" \
    "_JAVA_OPTIONS"="-Xmx2g"

# Run script
WORKDIR /usr/local/sbin/
COPY run_obp .
RUN bash run_obp
WORKDIR /opt/OBP/
COPY run_servers .
#Bash
CMD ["/bin/bash"]
