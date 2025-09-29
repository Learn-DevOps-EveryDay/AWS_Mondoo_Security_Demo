# AWS Mondoo Security Demo

## 🛡️ Project Goal: Shift-Left DevSecOps with Terraform

This project demonstrates the integration of **security-as-code** principles into the **AWS infrastructure lifecycle**. The core focus is on performing **static security analysis** and **policy compliance checks** *before* the code is provisioned, using **Terraform** for IaC and **Mondoo/cnspec** for security assessment.

---

## 🎯 Current Learning Focus and Roadmap

This project is a continuous learning exercise in advancing DevSecOps practices. My current goals include:

1.  **Live Environment Scanning Pipeline:** I am actively working on implementing a **separate CI/CD pipeline** dedicated to scanning the **live AWS environment**. This ensures continuous security assessment of deployed resources, complementing the static analysis performed here.
2.  **Custom Policy Development:** I am trying to build a library of **custom security policies** tailored to organizational needs, leveraging the power of **Mondoo Query Language (MQL)** and executing these checks using `cnspec`.

---

## 🔄 CI/CD Workflow: Conditional Execution

This pipeline is executed using `workflow_dispatch`, allowing the user to select the security scanner and explicitly choose between an **Apply** run or a dedicated **Destroy** run.

### Workflow Inputs

| Input | Description | Options |
| :--- | :--- | :--- |
| `securityScan` | Selects the IaC security scanner for Stage 1. | `checkov`, `mondoo`, `none` |
| `enableDestroy` | If set to `true`, the pipeline skips Stage 1 & 2 (Apply) and executes **Stage 3 (Destroy)**. | `true`, `false` |

### Pipeline Stages

| Stage | Job | Condition | Key Actions |
| :--- | :--- | :--- | :--- |
| **Trigger** | (N/A) | `on: workflow_dispatch` | Developer triggers run and selects security/action. |
| **Stage 1: Security Scan** | `checkov` or `mondoo_scan` | Runs **ONLY IF** `enableDestroy` is `false`. | Static analysis of IaC code. Failure requires code fix. |
| **Stage 2: Plan & Apply** | `terraform` | Runs **ONLY IF** `enableDestroy` is `false`. | **Init**, **Plan** (`tfplan`), **Apply** (`apply -auto-approve tfplan`). |
| **Manual Validation** | (Implicit) | Between Plan and Apply. | Requires manual review of the `plan-summary.txt` artifact. |
| **Stage 3: Destroy** | `destroy` | Runs **ONLY IF** `enableDestroy` is `true`. | **Init**, then **Destroy** (`destroy -auto-approve`) for mandatory cleanup. |

---

## ⚙️ Technologies Used

| Technology | Role in Project |
| :--- | :--- |
| **AWS** | Cloud platform hosting the infrastructure. |
| **Terraform** | IaC tool for provisioning and managing resources. |
| **GitHub Actions** | CI/CD platform automating all stages. |
| **Mondoo / cnspec** | Policy-as-Code for security compliance checks (MQL is used for custom policies). |
| **Checkov** | Static analysis tool for validating Terraform code. |

---

## 💡 Local Development and Execution

### Prerequisites

1.  An **AWS account** with configured credentials.
2.  **Terraform**, **Checkov** and **Mondoo/cnspec** installed locally.

### Local Steps

1.  **Clone the repo:**
    ```bash
    git clone [https://github.com/Learn-DevOps-EveryDay/AWS_Mondoo_Security_Demo.git](https://github.com/Learn-DevOps-EveryDay/AWS_Mondoo_Security_Demo.git)
    cd AWS_Mondoo_Security_Demo
    ```

2.  **Run Local Static Checks:**
    ```bash
    # Checkov
    checkov -d terraform-project/
    
    # Mondoo/cnspec
    cnspec scan terraform terraform-project/
    ```