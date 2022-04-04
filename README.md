# Week-13_Submission_README
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Cloud Security Network Diagram](https://user-images.githubusercontent.com/92959447/161470043-6cc744d6-43dc-4b1a-b0e1-f0f6b56d5684.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

```---
- name: Config Web VM with Docker
  hosts: webservers
  become: true
  tasks:
    - name: Uninstall apache2
      apt:
        name: apache2
        state: absent

    - name: docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

    - name: Install pip3
      apt:
        name: python3-pip
        state: present

    - name: Install Docker python module
      pip:
        name: docker
        state: present

    - name: download and launch a docker web container
      docker_container:
        name: dvwa
        image: cyberxsecurity/dvwa
        state: started
        restart_policy: always
        published_ports: 80:80

    - name: Enable docker service
      systemd:
        name: docker
        enabled: yes
  ```

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly accessible, in addition to restricting access to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_

Load balancers protect against DDoS attacks. If a server is taken out a load balancer can route traffic to other available servers so services remain functional. A jump box creates a secure access point for network administrators.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file systems of the VMs on the network and system system metrics.
What does Filebeat watch for? - Filebeat watches for log file events and forwards them.
What does Metricbeat record? - Metricbeat records metric data from the OS and services running on the server.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
| Web-1    | Server   | 10.0.0.5   | Linux            |
| Web-2    | Server   | 10.0.0.6   | Linux            |
| ElkNET-1 | ELKStack | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 76.227.98.100

Machines within the network can only be accessed by each other
Which machine did you allow to access your ELK VM? What was its IP address?

Jump-Box-Provisioner IP: 10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 76.227.98.100        |
| Web-1    | No                  | 10.0.0.4             |
| Web-2    | No                  | 10.0.0.4             |
| ElkNET-1 | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
What is the main advantage of automating configuration with Ansible? 

The main advantage of automating configuration with Ansible is that it saves time.

The playbook implements the following tasks:
_TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Install docker.io
- Install python3-pip
- Install Docker module
- Use more memory
- download and launch a docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![image](https://user-images.githubusercontent.com/92959447/161473613-cc3cf86a-3f7c-4a94-8909-4bff229d1d3a.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
10.0.0.5 and 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat
- Packetbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: Filebeat detects changes to the filesystem. Specifically, we use it to collect Apache logs.
- Metricbeat: Metricbeat detects changes in system metrics, such as CPU usage. We use it to detect SSH login attempts, failed sudo escalations, and CPU/RAM statistics.
- Packetbeat: Packetbeat collects packets that pass through the NIC, similar to Wireshark. We use it to generate a trace of all activity that takes place on the network, in case later forensic analysis should be warranted.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

_Answer the following questions to fill in the blanks:_
- Which file is the playbook? Where do you copy it?

install-elk.yml, ansible control node

- Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?

hosts file, you specify the IP of the machine in the hosts file

- Which URL do you navigate to in order to check that the ELK server is running?

http://51.120.77.18:5601/app/kibana
