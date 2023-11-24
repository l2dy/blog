---
up: 
related:
  - "[[AWS Pitfalls]]"
created: 2023-09-14
tags: 
---
# Aurora MySQL

## JDBC Drivers

### Amazon Web Services (AWS) JDBC Driver for MySQL

https://github.com/awslabs/aws-mysql-jdbc

> The AWS JDBC Driver for MySQL supports fast failover for Amazon Aurora with MySQL compatibility.

## Caveats and Gotchas

<https://repost.aws/knowledge-center/aurora-mysql-db-cluser-read-only-error>

### Smart driver

The Amazon Aurora DB cluster endpoints propagate DNS record updates automatically, but the process doesn't happen instantly. This can cause delays in responding to an event that occurred on the database and the event might be handled by the application. A Smart Driver uses the DB cluster topography through the INFORMATION_SCHEMA.REPLICA_HOST_STATUS metadata table, which is in near-real-time. This helps to route connections to the appropriate role, and helps load-balance across the existing replicas. MariaDB Connector/J is an example of a third party Smart Driver that has native support for Aurora MySQL.

Note: Even Smart Drivers might be affected by excessive DNS Caching.

### DNS caching

If you are not using a smart driver, then you depend on the DNS record updates and propagation after a failover event occurs. Aurora DNS zones use a short time-to-live (TTL) of 5 seconds, so it is important that your network and client configurations don't further increase this. DNS caching can occur at multiple layers of an architecture, such as the operating system (OS), the network layer and the application container. It is important that you understand how each of these layers is configured. If there is unintended DNS caching beyond the TTL of 5 seconds, it is possible that you will re-connect to the old writer after a failover.

Java Virtual Machines (JVM) can excessively cache DNS, indefinitely. When the JVM resolves a hostname to an IP address, it caches the IP address for a specified period of time (TTL). On some configurations, the JVM default TTL is set to never refresh DNS entries until the JVM is restarted. This can lead to read-only errors after a failover. In this case, it is important to manually set a small TTL so that it will periodically refresh.

# Interface Endpoint

## Private DNS for interface endpoints

If the private DNS option is enabled, an interface endpoint is created with a hidden private hosted zone attached to the associated VPC. Records in this hosted zone point the default service domain to ENIs of the interface endpoint, which have private IPs that isolated subnets can connect to.

Detaching a private hosted zone can take a few minutes, so it is not possible to recreate a deleted AWS service interface endpoint immediately.

```
private-dns-enabled cannot be set because there is already a conflicting DNS domain for ssm.<region>.amazonaws.com in the VPC
```

# Cloud9

## AWS managed temporary credentials

Some Cloud9, IAM and STS actions are restricted. See [Actions supported by AWS managed temporary credentials](https://docs.aws.amazon.com/cloud9/latest/user-guide/security-iam.html#auth-and-access-control-temporary-managed-credentials-supported).

* * *

> Currently, if your environment’s EC2 instance is launched into a private subnet, you can't use AWS managed temporary credentials to allow the EC2 environment to access an AWS service on behalf of an AWS entity (an IAM user, for example).

<https://docs.aws.amazon.com/cloud9/latest/user-guide/security-iam.html#auth-and-access-control-temporary-managed-credentials>

# Graviton Processor

[AWS Graviton Technical Guide](https://github.com/aws/aws-graviton-getting-started)

## Processor Specifications

|Processor	|Graviton2	|Graviton3(E)	|
|---	|---	|---	|
|Instances	|[M6g/M6gd](https://aws.amazon.com/ec2/instance-types/m6g/), [C6g/C6gd/C6gn](https://aws.amazon.com/ec2/instance-types/c6g/), [R6g/R6gd](https://aws.amazon.com/ec2/instance-types/r6g/), [T4g](https://aws.amazon.com/ec2/instance-types/t4g), [X2gd](https://aws.amazon.com/ec2/instance-types/x2/), [G5g](https://aws.amazon.com/ec2/instance-types/g5g/), and [I4g/Im4gn/Is4gen](https://aws.amazon.com/ec2/instance-types/i4g/)	|[C7g/C7gd/C7gn](https://aws.amazon.com/ec2/instance-types/c7g/), [M7g/M7gd](https://aws.amazon.com/ec2/instance-types/m7g/), [R7g/R7gd](https://aws.amazon.com/ec2/instance-types/r7g/), and [HPC7g](https://aws.amazon.com/ec2/instance-types/)	|
|Core	|[Neoverse-N1](https://developer.arm.com/documentation/100616/0301)	|[Neoverse-V1](https://developer.arm.com/documentation/101427/latest/)	|
|Frequency	|2500MHz	|2600MHz	|
|Turbo supported	|No	|No	|
|Instruction latencies	|[Instruction Latencies](https://developer.arm.com/documentation/PJDOC-466751330-9707/r4p1/?lang=en)	|[Instruction Latencies](https://developer.arm.com/documentation/pjdoc466751330-9685/latest/)	|
|Interconnect	|CMN-600	|CMN-650	|
|Architecture revision	|ARMv8.2-a	|ARMv8.4-a	|
|Additional  features	|fp16, rcpc, dotprod, crypto	|sve, rng, bf16, int8, crypto	|
|Recommended -mcpu flag	|neoverse-n1	|neoverse-512tvb	|
|RNG Instructions	|No	|Yes	|
|SIMD instructions	|2x Neon 128bit vectors	|4x Neon 128bit vectors / 2x SVE 256bit	|
|LSE (atomic mem operations)	|yes	|yes	|
|Pointer Authentication	|no	|yes	|
|Cores	|64	|64	|
|L1 cache (per core)	|64KB inst / 64KB data	|64KB inst / 64KB data	|
|L2 cache (per core)	|1MB	|1MB	|
|LLC (shared)	|32MB	|32MB	|
|DRAM	|8x DDR4	|8x DDR5	|
|DDR Encryption	|yes	|yes	|

## C/C++ on Graviton

[Source](https://github.com/aws/aws-graviton-getting-started/blob/main/c-c%2B%2B.md)

### Optimal processor features

On arm64 `-mcpu=` acts as both specifying the appropriate
architecture and tuning and it's generally better to use that vs `-march` if
you're building for a specific CPU.

CPU       | Flag    | GCC version      | LLVM verison
----------|---------|-------------------|-------------
Graviton2 | `-mcpu=neoverse-n1`\* | GCC-9^ | Clang/LLVM 10+
Graviton3(E) | `-mcpu=neoverse-512tvb`% | GCC 11+ | Clang/LLVM 14+

^ Also present in Amazon Linux2 GCC-7

\* Requires GCC-9 or later; otherwise we suggest using `-mcpu=cortex-a72`

% If your compiler doesn't support `neoverse-512tvb`, please use the Graviton2 tuning.

### Using SVE

The scalable vector extensions (SVE) require both a new enough tool-chain to
auto-vectorize to SVE (GCC 11+, LLVM 14+) and a 4.15+ kernel that supports SVE.
One notable exception is that Amazon Linux 2 with a 4.14 kernel doesn't support SVE;
please upgrade to a 5.4+ AL2 kernel.

# IAM

## Policy Limits

<https://aws.amazon.com/premiumsupport/knowledge-center/iam-increase-policy-size/>

### Managed policy limit

You can assign IAM users to up to 10 groups. You can also attach up to 10 managed policies to each group, for a maximum of 120 policies (20 managed policies attached to the IAM user, 10 IAM groups, with 10 policies each).

### Inline policy character quota

You can add as many inline policies as you want to an IAM user, role, or group. But the total aggregate policy size (the sum size of all inline policies) per entity cannot exceed the following quotas:

- User policy size cannot exceed 2,048 characters.
- Role policy size cannot exceed 10,240 characters.
- Group policy size cannot exceed 5,120 characters.

# S3

## Partitioning

<https://aws.amazon.com/premiumsupport/knowledge-center/s3-prefix-nested-folders-difference/>

A prefix is the complete path in front of the object name, which includes the bucket name. For example, if an object (123.txt) is stored as BucketName/Project/WordFiles/123.txt, the prefix is “BucketName/Project/WordFiles/”. If the 123.txt file is saved in a bucket without a specified path, the prefix value is "BucketName/".

A partitioned prefix in a bucket can support 3,500 PUT/COPY/POST/DELETE or 5,500 GET/HEAD requests per second. There is no limit to the number of prefixes you can have in a bucket.

Note: _In Amazon S3, there are no partitions for keys or objects._ Partitions exist only at the prefix level, and not at the object level. For more information about using prefixes in Amazon S3. See Organizing objects using prefixes.