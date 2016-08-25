DevOps & Cloud Infrastructure (SEIS 665) Curriculum
===================================================

Overview
--------

In late 2015, the faculty and administration at the [University of St. Thomas Graduate Programs in Software](http://www.stthomas.edu/gradsoftware/) asked me to review their current IT graduate curriculum to determine how well it aligned with current IT practices. While much of the curriculum was still relevant, it was clear that the program didn't address some of the dramatic changes reshaping regional IT organizations. The idea for a new graduate IT course was born from that review process and subsequent discussions with other practitioners in the IT field.

DevOps is rapidly gaining adoption at IT organizations across the world. It represents an IT cultural transformation combining ideas from Lean, Agile, and software development. Cloud infrastructure is a key enabler of DevOps practices, and is a foundational component of modern Internet services.

Students that understand how to wield DevOps practices and create infrastructure as code are empowered to deliver IT services at nearly any scale. These students represent the future of our IT organizations.

Audience
--------

The curriculum was designed for graduate students at a large private university located near a major metropolitan area. The students represent a mixture of age groups, cultural backgrounds, and experience levels. Most students tend to be working professionals with 5-15 years of experience. Approximately 50% of the students are International students coming from a wide variety of educational systems.

Students taking this course may have 10+ years of IT experience or no experience at all. Some of the students are transitioning into IT as a new career. One of the challenges I faced while creating this curriculum was figuring out how to calibrate the technical depth of the content. In most cases I opted to make the content more rigorous to challenge experienced students while at least giving less experienced students to new ideas. The course calibration will likely require a few semesters to properly fine tune.

Curriculum Approach
-------------------

Let me be completely transparent. I've never developed educational curriculum before and I didn't follow any particular methodology. I created the kind of class that I would register for and sit through.

It's based around a process of exploration and hands-on learning. Students are presented with a few theories and best practices, and then we dive straight into implementation. We will learn by doing. My hope is that an appreciation for DevOps practices will emerge as students progress through the course.

I'm treating this curriculum as a grand experiment and hoping to receive fast feedback from students. I expect to make meaningful changes in future months based on student and peer critiques.

The course is focused on helping students develop skills related to DevOps and cloud infrastructure. Students learn how to walk before they run. Each lesson builds on the learnings from the previous lesson.

The 14-week course is partitioned into 12 lectures and 2 exams. Each lecture is designed cover 3 hours worth of content. Students are given assignments each week for a total of 10 assignments (or 11 if you count the first assignment which just involves account setup).

Students start out the course by learning fundamental version control and Linux system administration skills. The first two lessons are designed to bootstrap students into the core parts of the curriculum. Without these basic skills, it would be difficult for students to navigate many of the future assignments.

The next few courses introduce students to fundamental infrastructure deployment patterns, virtualization, and cloud infrastructure. The cloud infrastructure curriculum is based on the AWS Solution Architect Certification blueprint. The idea is that after completing this course students can pursue an AWS certification with a small amount of incremental effort. Most of the lessons learned using AWS may be applied to other cloud providers such as Microsoft or Google.

Students build on their infrastructure experience by learning how distributed applications are designed to take advantage of this dynamic infrastructure. They will learn that this infrastructure isn't built using traditional ad hoc methods. Students learn how to create infrastructure using code and how to programatically manage the configuration of that infrastructure over time.

Finally, students are formally introduced to DevOps practices, including continuous integration and delivery. I struggled with the placement of the formal DevOps introduction in the course. Should students learn about DevOps culture and practices right away despite the fact that many of them would have no context for these practices? Or should I reveal DevOps as a set of practices that embraces many of the learnings from previous lessons in the course? For now the latter option has won out. This option carries greater risk and I won't be surprised if it changes in the future.

The course completes with lessons on containerization and data center architectures. The latter is an area where I have significant professional experience and can add unique value as an educator. However, this topic may be replaced in the future -- perhaps by a greater focus on containerization as that technology matures.

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
| 1    | Course Introduction, Source control, Git                               |
| 2    | Linux fundamentals, Package management, Shell scripting                |
| 3    | Infrastructure fundamentals, Virtualization, Distributed infrastructure|
| 4    | Cloud computing, AWS, IAM, EC2, S3                                     |
| 5    | Cloud computing, AWS, VPC, RDS, ELB                                    |
| 6    | Cloud computing, AWS, Autoscaling, Cloud Watch, Route53, SQS, SNS, SES |
| 7    | Midterm                                                                |
| 8    | Distributed application architecture, Web services, REST/ JSON / YAML  |
| 9    | Infrastructure as Code, CloudFormation                                 |
| 10   | Infrastructure As Code                                                 |
| 11   | DevOps, Continuous integration & delivery                              |
| 12   | Containers, Docker                                                     |
| 13   | Data center architecture                                               |
| 14   | Final exam                                                             |

Build
-----

This repository requires the [Asciidoctor](http://asciidoctor.org/) toolchain
to convert AsciiDoc files into PDF files.

The `generate-pdfs.sh` script in the `/build` directory will create PDF
versions of all AsciiDoc files located in the root directory.
The script can utilize Docker if it's available on the build
platform.

The `generate-syllabus.sh` script in the `/build` directory will create an HTML
version of the course syllabus.

TO DO
-----

* I don't know if the current lecture content will fill a 3-hour lecture period. It's likely that some of the lectures are too short and some are too long.
* I need to improve the skill connection between assignments. I originally designed each lecture as a separate module. Assignments should leverage skills attained in previous learnings.

License
-------

All material, except those images not owned by me and used for educational purposes, is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a>

Thanks
------

Special thanks go out to Charlie Betz for his collaboration and encouragement. I also would like to thank Dr. Bhabani Misra and Dr. Brad Rubin for their support and mentorship. Finally, thank you to my wife for letting me attempt this.
