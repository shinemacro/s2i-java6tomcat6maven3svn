# s2i-Java6Tomcat6Maven3Svn
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
# LABEL maintainer="Your Name <your@email.com>"
MAINTAINER Zhao Yaohong <zhaoyaohong@aliyun.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
#LABEL io.k8s.description="Platform for building xyz" \
#      io.k8s.display-name="builder x.y.z" \
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,x.y.z,etc."
LABEL io.k8s.description="Platform for building and running java6 web applications" \
      io.k8s.display-name="Java6 Tomcat6 Maven3 Svn" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java,java6,tomcat,maven,svn"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
ENV JAVA_VERSION 1.6.0
RUN yum makecache && \
#  yum update -y && \
  yum install -y curl subversion && \
  yum install -y java-$JAVA_VERSION-openjdk java-$JAVA_VERSION-openjdk-devel && \
  yum clean all -y

ENV JAVA_HOME /usr/lib/jvm/java

# install maven
ENV MAVEN_VERSION 3.2.5
RUN (curl -0 http://www.eu.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | \
    tar -zx -C /usr/local) && \
    mv /usr/local/apache-maven-$MAVEN_VERSION /usr/local/maven && \
    ln -sf /usr/local/maven/bin/mvn /usr/local/bin/mvn && \
    mkdir -p $HOME/.m2 && chmod -R a+rwX $HOME/.m2

# COPY Additional files,configurations that we want to ship by default, like a default setting.xml
#COPY ./contrib/settings.xml $HOME/.m2/

ENV PATH=/usr/local/maven/bin/:$PATH

ENV MAVEN_HOME /usr/local/maven

# install tomcat-6.0.37
RUN (curl -0 http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.37/bin/apache-tomcat-6.0.37.tar.gz | \
    tar -zx -C /usr/local) && \
    mv /usr/local/apache-tomcat-6.0.37 /opt/apache-tomcat-6.0.37 && \
    chmod -R a+rw /opt && \
    chmod a+rwx /opt/apache-tomcat-6.0.37/* && \
    chmod +x /opt/apache-tomcat-6.0.37/bin/*.sh && \
    rm -rf /opt/apache-tomcat-6.0.37/webapps/*


# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root
RUN chown -R 1001:1001 /opt

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]

