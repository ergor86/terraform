
/*
import {
    id = "role-acesso-ssm"
    to = aws_iam_role.role-acesso-ssm
}

import {
    id = "role-acesso-ssm"
    to = aws_iam_instance_profile.role-acesso-ssm
}
*/

import {
    id = "sg-0979706c497a7b443"
    to = aws_security_group.bia-db
}

import {
    id = "sg-00441de9cbdc2d140"
    to = aws_security_group.bia-dev
}

import {
    id = "sg-080e9cf3f42368d9b"
    to = aws_security_group.bia-web
}

import {
    id = "sg-02c6bd8a63274f75c"
    to = aws_security_group.bia-alb
}

import {
    id = "sg-0b2dc64dd6efabd6e"
    to = aws_security_group.bia-ec2
}