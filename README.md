OpenShift S2I Builder for Java6 Web App
====
Openshift s2i application template for JavaEE WAR deployment with Tomcat 6.

Supported tags and respective `Dockerfile` links
---------

- [`s2i-java6tomcat6maven3svn` (*Dockerfile*)](https://github.com/shinemacro/s2i-java6tomcat6maven3svn/blob/master/Dockerfile)


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
* JDK 1.6 + Tomcat 6.0.37 + Maven 3.2.5 + SVN

CentOS versions currently supported are:
* CentOS 7

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
  1.First load ImageStream:

    ```
    $ oc create -n openshift -f https://raw.githubusercontent.com/shinemacro/s2i-java6tomcat6maven3svn/master/s2i-java6tomcat6maven3svn-is.json
    ```
  
  2.Once the ImageStream s2i-java6tomcat6maven3svn has been registered, you can create an template (include: route, service, is, bc, dc and pod) with:
  
    ```
    $ oc create -n openshift -f https://raw.githubusercontent.com/shinemacro/s2i-java6tomcat6maven3svn/master/s2i-java6tomcat6maven3svn-all-template.json
    ```
  As also you can create an template (only include: bc, dc and pod) with:
  
    ```
    $ oc create -n openshift -f https://raw.githubusercontent.com/shinemacro/s2i-java6tomcat6maven3svn/master/s2i-java6tomcat6maven3svn-withoutservice-template.json
    ```
  
  3.Click on 'Add to Project' in OpenShift CP Web Console (UI) to create a new application and then select the 's2i-java6tomcat6maven3svn-all' or 's2i-java6tomcat6maven3svn-withoutserivce' template from the 'Browse' images tab.  You will then be presented with a form where you can specify 
  * APPLICATION_NAME: A *name* for your web application.
  * APPLICATION_PATH(Optional): Specify the application build path, the tomcat webapps file name.
  * APPLICATION_HOSTNAME(Optional): A hostname for route
  * SVN_URI: The SVN repository URL containing your Java6 web application source code.
  * SVN_USERNAME: Specify the subversion username.
  * SVN_PASSWORD: Specify the subversion user's password.
  
  Next, click on 'Create' application.  This will invoke the *S2I process* which will build your application, containerize your application (as explained above), push the newly built image into the integrated docker registry and finally deploy a Pod containing your application.
  
  Congrats! You have now successfully created your own S2I builder image for building and deploying containerized Java Web applications on OpenShift.
