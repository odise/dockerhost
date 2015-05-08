dockerhost-cookbook
==========
Chef cookbook to create a foundation to use Docker container managed with the help of service management software [systemd](http://www.freedesktop.org/software/systemd/) and [Upstart](http://upstart.ubuntu.com/).

It is designed to be used in combination with AWS OpsWorks and provides an abstraction layer to deploy systemd service units and Upstart config files. 

Requirements
------------

- Chef 11

Attributes
----------

|Key|Dfault|Description|
|---|------|-----------|
||||

Usage
-----

The current implementation defines the upper layer of Docker container orchestration with the help of Linux service management software natively shipped with CentOS7, Ubuntu 14.04 and Amazon Linux 2014.09. 

The model based on the following layers:

- container host provisioning (dockerhost-cookbook, this repository)
- process management file abstraction ([container-cookbook](https://github.com/odise/container-cookbook))
- service specific config file implementation ([systemd-cookbook](https://github.com/odise/systemd-cookbook))

In order to write a cookbook to be used as base `Custom Chef Recipes`for an AWS OpsWork Layer, add a `depends 'dockerhost'` statement in your Berksfile and follow the `example_cookbook` in `cookbooks` folder. Clone this repository and add your implementation alternatively.

OpsWorks App deployments examples
---------------------------------
In order to integrate the dockerhost-cookbook and a customized container unit file implementation in AWS OpsWorks create a Stack and configure the Layer as follows:

![image](https://raw.githubusercontent.com/odise/dockerhost/master/pictures/integration_-_amazon_dockerhost_%E2%80%93_AWS_OpsWorks.png)

To deploy different parts of the cookbook create OpsWorks Apps and give it some meaningful names. This can be reused within your cookbook.

![image](https://raw.githubusercontent.com/odise/dockerhost/master/pictures/Add_example_app_-_Apps_-_amazon_dockerhost_%E2%80%93_AWS_OpsWorks.png)

`recipes/default.rb`

```
# will be executed when deploying OpsWorks "Add example App" 
if ( deploy? 'add_example_app' )

	container_unit 'container-test' do
   		depend ["docker"]
   		image "odise/busybox-curl"
   		command "/bin/sh -c 'while true; do echo ${VAR1} and ${VAR2}; sleep 2; done'"
   		environment [
   			"VAR1=VALUE1",
   			"VAR2=VALUE2"
	    ]
	end
  		
end
	
# will be executed when deploying OpsWorks "Remove example App" 
if ( deploy? 'remove_example_app' )

	container_unit 'container-test' do
		action :remove
	end

end

```
Test
----

In order to test the cookbook two test-kitchen profiles (for CentOS7 and Ubuntu 14.04) defined in the `.kitchen.yml`. Try

```
$ kitchen create default-centos-71
$ kitchen converge default-centos-71
```
or 

```
$ kitchen create default-ubuntu-1404
$ kitchen converge default-ubuntu-1404
```

