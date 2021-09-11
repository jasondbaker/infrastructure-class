<?php
$instance_id = file_get_contents("http://169.254.169.254/latest/meta-data/instance-id");
echo "Hi, I'm instance ", $instance_id, "\n";
?>