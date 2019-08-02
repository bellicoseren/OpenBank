FROM openbankproject/obp-base
MAINTAINER OpenBankProject <contact@openbankproject.com> NovaSolutions <rgutierrez@novasolutionsystems.com>
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

# API
WORKDIR /opt/OBP/OBP-API/obp-api/src/main/resources/props
RUN mv sample.props.template default.props
WORKDIR /opt/OBP/OBP-API
#RUN ./mvn.sh install -pl .,obp-commons && ./mvn.sh jetty:run -pl obp-api
# /API

# Social Finance
WORKDIR /opt/OBP/OBP-Docker/full
RUN cp lift_proto.db.h2.db /opt/OBP/OBP-API/
WORKDIR /opt/OBP/OBP-Docker/full/props
RUN cp Social-Finance.default.props /opt/OBP/Social-Finance/src/main/resources/props/default.props
WORKDIR /opt/OBP/Social-Finance/
#RUN mvn package -DskipTests
# /Social Finance

# API EXPLORER
WORKDIR /opt/OBP/OBP-Docker/full/props
RUN cp API-Explorer.default.props /opt/OBP/API-Explorer/src/main/resources/props/default.props
WORKDIR /opt/OBP/API-Explorer/
#RUN mvn package -DskipTests
# /API EXPLORER

## Run script
ADD full/run_obp /usr/local/sbin/
WORKDIR /opt/
#CMD /usr/local/sbin/run_obp
CMD ["/bin/bash"]
