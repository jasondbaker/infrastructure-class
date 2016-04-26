##GRADUATE PROGRAMS IN SOFTWARE  
University of St. Thomas  
St. Paul, MN 55105
---

DevOps & Cloud Infrastructure (SEIS 768)
========================================

Description
-----------

This course covers the engineering and design of IT infrastructure, focusing on
cloud-scale distributed systems and modern DevOps practices. IT
infrastructure deployment practices are rapidly changing as organizations build
"Infrastructure  as code" and adopt cloud computing platforms. We will examine
the theory behind these modern practices and the real-world implementation
challenges faced by IT organizations.

Objectives
----------

*   Understand how IT organizations are deploying modern infrastructure and
how to build "Infrastructure as code".

*   Understand how to architect cloud-scale distributed systems and the key
design patterns used to enhance scalability and reliability within these
systems.

*   Develop specific skills related to DevOps practices including source
control management, package management, and configuration management.

Lecture Schedule
----------------

| Week | Topic                                                                  |
|------|------------------------------------------------------------------------|
| 1    | Course Introduction, Source control, Git                               |
| 2    | Linux fundamentals, Package management, Shell scripting                |
| 3    | Infrastructure fundamentals, Virtualization, Distributed infrastructure design and operations                                                           |
| 4    | Cloud computing, AWS, IAM, EC2, S3                                     |
| 5    | Cloud computing, AWS, VPC, RDS, ELB                                    |
| 6    | Cloud computing, AWS, Autoscaling, Cloud Watch, Route53, SQS, SNS, SES |
| 7    | Midterm                                                                |
| 8    | Distributed application architecture, Web services, REST/ JSON / YAML  |
| 9    | Configuration management I                                             |
| 10   | Configuration management II                                            |
| 11   | Containers, Docker                                                     |
| 12   | DevOps, Continuous integration & deployment, Jenkins                   |
| 13   | Data center architecture                                               |
| 14   | Final exam                                                             |

Build
-----

This repository requires the [Asciidoctor](http://asciidoctor.org/) toolchain
to convert AsciiDoc files into PDF files.
 
The `generate-pdfs.sh` script in the `/build` directory will create PDF
versions of all AsciiDoc files located in the root directory.
