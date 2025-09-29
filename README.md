# AWS Mondoo Security Demo

## Project Goal: Shifting Security Left

This repository demonstrates the integration of **security-as-code** principles into the **AWS infrastructure lifecycle**. The core focus is on performing security and compliance checks *before* the code is deployed, using **Terraform** for provisioning and **Mondoo/cnspec** for security analysis.

---

##  Current Learning Focus and Roadmap

This project is a continuous learning exercise in DevSecOps. My immediate goals for advancing this workflow include:

1.  **Live Environment Scanning Pipeline:** I am actively working on implementing a separate CI/CD pipeline dedicated to scanning the **live AWS environment**. This pipeline will ensure continuous security assessment of deployed resources, complementing the static analysis performed earlier in the process.
2.  **Custom Policy Development:** I am building a library of **custom security policies** tailored to specific organizational needs. This involves leveraging the power of **Mondoo Query Language (MQL)** and executing these checks using the `cnspec` tool.

---

## CI/CD & DevSecOps Workflow

This workflow illustrates the current automated flow for managing infrastructure code deployment, integrating security scans, and utilizing manual validation gates.


```
    A[Developer Pushes Code to GitHub] --> B(Workflow Dispatch Trigger);
    C[Stage 1: Static Code Analysis using Checkov/Mondoo]:
    C -- Success --> D[Stage 2: Terraform Init];
    D --> E[Stage 2: Terraform Plan];
    E --> F{Manual Validation / Approval Gate};
    F -- Approved --> G[Stage 2: Terraform Apply];
    G --> H[Stage 3: Terraform Destroy];
```