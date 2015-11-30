# simple-logging-pipeline

  This is a small example how to create and deploy a small logging pipeline with Elasticsearch, Logstash and Kibana. 

## Requirements
 * chef-dk >= 0.9.1 (optional requirement)
 * vagrant >= 1.5.4    

## Pipeline Idea

Shipper (syslog, httpd, lumberjack) -> Logstash -> Elasticsearch -> Kibana
  
In Vagrant there are three different VMs for these components:

  * es (elasticsearch + kibana)
  * logstash
  * shipper (lumberjack + httpd + syslog)

## Deployment
  For the deployment Chef is used together with Test-Kitchen and Serverspec for the tests.

## How to start

  0. 'chef exec vagrant up' or only 'vagrant up' if you already have vagrant installed manually
  1. after the chef-runs are finished, go to http://192.168.33.51:5601
  2. configure an index pattern
  3. experiment! for example visit http://192.168.33.49 (the httpd webserver) and track the events in kibana

## Testing

  You can run 'chef exec kitchen test' in every cookbook to test it. Note that this is only an example.

## Security

  Note that this is only an example. Credentials in the data_bags are only creating for this example. Don't use them in production !  

## TODOs (Scaling up/out)

* Use Redis or RabbitMQ as a broker between the Logstash-Agent (lumberjack in my case) and the central Logstash

* Add proper mappings to Elasticsearch

* Add more nodes to the Elasticseach-Cluster

* Modify the Apache logs to avoid a lot of filtering on the cental Logstash
