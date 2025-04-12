FROM tomcat:8jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
WORKDIR /usr/local/tomcat/
# Like systemctl start Tomcat but in script
CMD ["catalina.sh", "run"]
