# Before begin:  
--  

All the script is tested on Centos7, Not for other version or release Linux.

# Usage:
--

First you download the shell script and give it execute permission.

```  ./work.sh up ```

This will intall Docker and build some images we need.   
By the way, a Jenkins instance will run in the host __8090__ port.

``` ./work.sh dev ```  

This command will fast build a local development environment which consist one nginx docker(include .zip file) and a tomcat docker(run a .war file).  

---

If want to use a __CI/CD__ environment to build and deploy service, just run   

``` ./work.sh down ```  

Open Browser access jenkins, you need do some configurations like create a pipeline and add some parameters, credentials. I write a Jenkinsfile and push it on GitHub, so we choose Pipeline script from SCM.

In jenkins CI/CD workflow, you just click build with parameters, input which environment(dev or prod) you want to deploy and the images version(docker tag).

I designd two environment to deploy, because I just have one host to do this, so I use docker compose to deploy, So I do not use Ansible or whatever tools.    

The prod environment has a simple haproxy before the three nginx docker and two tomcat docker.

---  

For log, whether it is a public cloud or private cloud. I think we can use ELF or EFK to collect and view.   
  
For monitoring, a good choice for cloud-native product is to deploy Prometheus. Both tools mentioned above can be easily deploy. If we use k8s, we can use helm to deploy.  

for HA, we can deploy keepalived before some haproxy, this can avoid some single node fail.  

