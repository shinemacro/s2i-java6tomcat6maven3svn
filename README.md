# s2i-java6tomcat6maven3svn
Openshift s2i application template for JavaEE WAR deployment with Tomcat 6..( Java6 Tomcat6 Maven3 Svn S2I image )

Supported tags and respective `Dockerfile` links
---------

- [`java6-maven-svn` (*Dockerfile*)](http://github.com/shinemacro/s2i-java6tomcat6maven3svn/Dockerfile)


This repository contains the source for building various versions of
the Java application as a reproducible Docker image using
[source-to-image](https://github.com/openshift/source-to-image).
Users can choose between RHEL and CentOS based builder images.
The resulting image can be run using [Docker](http://docker.io).

For more information about using these images with OpenShift, please see the
official [OpenShift Documentation](https://docs.openshift.org/latest/using_images/s2i_images/python.html).

Versions
--------
Java versions currently provided are:
* JDK-1.6 + Tomcat 6.0.37 + Maven 3.2.5 + SVN

CentOS versions currently supported are:
* CentOS7

Installation
------------

To build a Java image:

  To build a Java image with Maven, you need to run the build on a properly.

    ```
    $ git clone https://github.com/shinemacro/s2i-java6tomcat6maven3svn.git
    $ cd s2i-java6tomcat6maven3svn
    $ make
    ```

    This image is also available on DockerHub. To download it run:

    ```
    $ docker pull zhaoayohong/s2i-java6tomcat6maven3svn:latest
    ```

Test in Openshift
----
  First load all the needed resources in a project.
    ```
    $ oc import image zhaoyaohong/s2i-java6tomcat6maven3svn --all
    ```
  Once the builder s2i-java6tomcat6maven3svn has been registered, you can create an template with:
    ```
    $ oc import image zhaoyaohong/s2i-java6tomcat6maven3svn --all
    ```
  
  Instant app already provided as template
  Using the s2i-java6tomcat6maven3svn builder image using a regular SVN repository
  
