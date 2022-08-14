FROM tomcat:9.0-jdk11
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./target/devopssampleapplication.war /usr/local/tomcat/webapps/ROOT.war