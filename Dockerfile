FROM tomcat:8.0-alpine

LABEL maintainer="rakesh635@gmail.com"

ADD target/addressbook.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [“catalina.sh”, “run”]
