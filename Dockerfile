FROM tomcat:9-jre8-alpine
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./target/devopssampleapplication.war /usr/local/tomcat/webapps/ROOT.war