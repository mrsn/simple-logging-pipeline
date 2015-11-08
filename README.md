# simple-logging-pipeline

## Requirements
  chef-dk >= 0.9.1 (optional requirement)
  vagrant >= 1.5.4    

## Pipeline Idea

Shipper(syslog, httpd, lumberjack) -> Logstash -> Elasticsearch -> Kibana
  
  In Vagrant there are three different VMs for these components:

  * es (elasticsearch + kibana)
  * logstash
  * shipper (lumberjack + httpd + syslog)


For the deployment I've used Chef together with Test-Kitchen and Serverspec for the tests.

## How to start

  0. 'chef exec vagrant up' or only 'vagrant up' if you already have vagrant installed manually
  1. after the chef-runs are finished, go to http://192.168.33.51:5601

## Testing

  you can run 'chef exec kitchen test' in every cookbook to test it 
