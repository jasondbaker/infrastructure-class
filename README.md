![transfer workflow](https://github.com/jasondbaker/infrastructure-class/actions/workflows/transfer.yml/badge.svg)

DevOps & Cloud Infrastructure (SEIS 615) Curriculum
===================================================

Overview
--------

In late 2015, the faculty and administration at the [University of St. Thomas Graduate Programs in Software](http://www.stthomas.edu/gradsoftware/) asked me to review their current IT graduate curriculum to determine how well it aligned with current IT practices. While much of the curriculum was still relevant, it was clear that the program didn't address some of the dramatic changes reshaping IT organizations. The idea for a new graduate IT course was born from that review process and subsequent discussions with other practitioners in the IT field such as Charlie Betz, Dr. Nicole Forsgren, and John Willis.

DevOps is rapidly gaining adoption at IT organizations across the world. It represents an IT cultural transformation combining ideas from Lean, Agile, and software development. Cloud infrastructure is a key enabler of DevOps practices, and is a foundational component of modern Internet software platforms.

Students that understand how to wield DevOps practices and create infrastructure as code are empowered to deliver IT services at nearly any scale. These students represent the future of our IT organizations.

Audience
--------

The curriculum was designed for graduate students at a large private American university located in the Minneapolis-St. Paul area. The students represent a mixture of age groups, cultural backgrounds, and technical experience levels. Most students tend to be working professionals with 5-15 years of corporate experience. Approximately 40% of the students are International students coming from a wide variety of educational systems.

Students taking this course may have 10+ years of IT experience or no experience at all. Some of the students are transitioning into IT as a new career. One of the challenges I faced while creating this curriculum was figuring out how to calibrate the technical depth of the content. In most instances, I opted to make the content more rigorous to engage experienced students while giving less experienced students exposure to new ideas.

Curriculum Approach
-------------------

Hundreds of graduate students have taken this course since 2015 and the curriculum is iteratively improved each semester based on student feedback and technology trends. I practice what I preach. Ultimately I created the kind of class that I'd like to take.

The curriculum is based around a process of exploration and hands-on learning. Students are presented with a few theories and best practices, and then we dive straight into real-world implementation. We learn by doing. My hope is that an appreciation for DevOps practices will emerge as students progress through the course.

The course is focused on helping students develop skills related to DevOps and cloud infrastructure. Students learn how to walk before they run. Each lesson builds on the learnings from the previous lesson.

The 14-week course is partitioned into 12 lectures and 2 exams. Each lecture is designed cover 3 hours worth of content. Students are given assignments each week for a total of 10 assignments (or 11 if you count the first assignment which just involves account setup).

Students start out the course by learning fundamental version control and Linux system administration skills. The first two lessons are designed to bootstrap students into the core parts of the curriculum. Without these basic skills, it would be difficult for students to navigate many of the future assignments.

The next few courses introduce students to fundamental infrastructure deployment patterns, virtualization, and cloud infrastructure. The cloud infrastructure curriculum is loosely based on the AWS Solution Architect Certification blueprint. The idea is that after completing this course students can pursue an AWS certification with a small amount of incremental effort. Most of the lessons learned using AWS may be applied to other cloud providers such as Microsoft or Google.

Students build on their infrastructure experience by learning how distributed applications are designed to take advantage of this dynamic infrastructure. They will learn that this infrastructure isn't built using traditional ad hoc methods. Students learn how to create infrastructure using code and how to programmatically manage the configuration of that infrastructure over time.

Finally, during the last quarter of the course students are formally introduced to DevOps practices, including continuous integration and delivery. The course finishes with lectures on containerization, service discovery, and container orchestration platforms.

Course Description
------------------

This course covers the engineering and design of IT infrastructure, focusing on
cloud-scale distributed systems and modern DevOps practices. IT
infrastructure deployment practices are rapidly changing as organizations build
infrastructure as code and adopt cloud computing platforms. We will examine
the theory behind these modern practices and the real-world implementation
challenges faced by IT organizations.

Objectives
----------

*   Understand how IT organizations are deploying modern infrastructure and
how to build infrastructure as code.

*   Understand how to architect cloud-scale distributed systems and the key
design patterns used to enhance scalability and reliability within these
systems.

*   Develop specific skills related to DevOps practices including source
control management, package management,
and configuration management.

Lecture Schedule
----------------

| Week | Topic                                                                  |
|------|------------------------------------------------------------------------|
| 1    | Course Introduction, Distributed Infrastructure Patterns               |
| 2    | Linux fundamentals, Package management, Shell scripting                |
| 3    | Virtualization, Cloud computing, AWS Fundamentals (IAM/ EC2/ S3)       |
| 4    | AWS Networking, Databases, & Security                                  |
| 5    | AWS Integration, Management & Cloud-native patterns                    |
| 6    | DevOps Practices, Continuous Integration & Delivery                    |
| 7    | Midterm Challenge                                                      |
| 8    | Infrastructure as Code, AWS CloudFormation                             |
| 9    | Configuration Management, Ansible                                      |
| 10   | Software Delivery Pipelines, AWS CodePipline                           |
| 11   | Containers, Docker                                                     |
| 12   | Serverless Applications, AWS Lambda, DynamoDB, Kinesis                 |
| 13   | Service discovery, Service orchestration, Fargate                      |
| 14   | Final Challenge                                                        |

License
-------

All material, except those images not owned by me and used for educational purposes, is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a>

Thank you
---------

None of the ideas I present in this curriculum are original and I take credit for nothing other than being a collector of ideas. I stand on the shoulders of giants such as Jez Humble, Gene Kim, Martin Fowler, Dr. Nicole Forsgren, John Willis, John Allspaw, Kief Morris, and others. All of you have transformed my understanding of my life's work.

Special thanks go out to Charlie Betz for his collaboration and encouragement. I also would like to thank Dr. Bhabani Misra and Dr. Brad Rubin for their support and mentorship. Finally, thank you to my wife for letting me attempt this.
