# terraform_modEach run block in GitHub Actions runs in a separate shell, which means that the current working directory will not persist between different run blocks. So, after the first step (cd srikanth1/Development), the working directory will not be maintained for the subsequent steps.

to run this pipeline,we need to spin up a self hosted runner (ec2) with custom AMI (having terraform pre-installed).
to generate a custo AMI anytime use the below repo 
https://github.com/skommana04/packer.git