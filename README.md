# Deploying a Static Website Using Terraform and AWS CLI

This project demonstrates how to deploy a static website on AWS using Terraform. The deployment includes setting up an S3 bucket, configuring CloudFront for CDN, and setting up Route 53 for DNS management.

## Table of Contents8
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Terraform Configuration](#terraform-configuration)
  - [Providers](#providers)
  - [S3 Bucket](#s3-bucket)
  - [CloudFront Distribution](#cloudfront-distribution)
  - [Route 53 Configuration](#route-53-configuration)
- [Conclusion](#Conclusion)
- [Screenshot Output](#screenshot_outputs)


## Prerequisites

- AWS Account
- AWS CLI installed and configured
- Terraform installed

## Setup Instructions


I installed and configured AWS CLI on my window machine so i can communicate directly with aws using terraform

> To setup your cli run
`aws configure` then input you credentials

## Terraform Configuration
> The provider.tf file contains the cloud provider used for this project

### The Major resources are divided into modules and each module performs a unique task

## `S3_BUCKET MODULE:`
- Creates a private s3 bucket 
- Copies the contents of a local directory to the s3 bucket by looping through each of the files

## `CLOUDFRONT MODULE`
- Creates a Cloudfront Distribution to serve website contents faster
- Uses the origin access control (OAC) policy to serve private  s3 bucket website files.
- 
## `ROUTE53 MODULE`
- Creates hosted zone for your domain name
- Creates a validated Certificate that would be used to serve your website content securely using domain name (https)
- Certificate was successfully issued to domain name

### Conclusion and further modification
- Though i was not able to get the domain name to display my s3 website content due to time factor.
- I got a route53 error page when i tried to access the website using domain name.
- When i inspected my aws console i noticed the cloudfront distribution was not linked to the certificate for my domain name
- I'll continue to work on this to connect domain name to serve my s3 bucket website. 

## Screenshots

![cloudfront website](./img/Screenshot%202024-06-28%20200443.jpg)
![cloudfront distribution](./img/Screenshot%202024-06-28%20201038.jpg)
![certificate](./img/Screenshot%202024-06-28%20201012.jpg)



