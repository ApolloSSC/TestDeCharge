FROM java:8
# JMeter Version
ARG JMETER_VERSION="5.4.1"

# Download and unpack the JMeter tar file
RUN cd /opt \
 && wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --no-check-certificate \
 && tar xzf apache-jmeter-${JMETER_VERSION}.tgz \
 && rm apache-jmeter-${JMETER_VERSION}.tgz

# Create a symlink to the jmeter process in a normal bin directory
RUN ln -s /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter /usr/local/bin

# Copying custom property file
COPY user.properties /opt/apache-jmeter-${JMETER_VERSION}/bin/user.properties
COPY plugins/ /opt/apache-jmeter-${JMETER_VERSION}/lib/ext/

# Indicate the default command to run
ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD jmeter -t "/opt/apache-jmeter-${JMETER_VERSION}/tests/Lab - Test Plan.jmx"