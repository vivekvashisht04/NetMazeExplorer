# NetMazeExplorer

## Project Workflow

<div align="center">
    <img src="https://github.com/user-attachments/assets/2981a3af-217a-43cd-b4f1-6152436d846f" alt="Project Architecture Diagram">
</div>


## Project Overview
Welcome to **NetMazeExplorer**, a comprehensive project designed to implement and manage virtual networking in Azure. This project focuses on creating a secure, hybrid networking environment where on-premises networks connect securely to Azure resources using Azure's networking capabilities. The goal is to ensure secure data transition and effective resource access controls.

## Features
- **Hybrid Networking Setup:** Connect on-premises networks to Azure using secure VPN and VNet configurations.
- **Secure Administrative Access:** Implement Azure Bastion across the entire project for secure VM access.
- **Private Access to Azure PaaS Services:** Ensure that PaaS services are accessible only through secure private endpoints.
- **Load Balancer Configuration:** Set up and test Azure Load Balancers for high availability and load distribution.
- **Monitoring and Auditing:** Comprehensive monitoring using Azure Monitor and NSG Flow Logs to ensure network security and performance.


## Azure Services Used
- **Azure Virtual Network (VNet):** For creating isolated network environments.
- **Azure VPN Gateway:** To establish secure site-to-site VPN connections.
- **Network Security Groups (NSGs):** For managing traffic within the VNets.
- **Azure Bastion:** To securely manage VMs without exposing them to the internet.
- **Azure Private Link:** To securely connect to Azure PaaS services.
- **Azure DNS:** For custom domain name resolutions within the VNet.
- **Azure Load Balancer:** To distribute network traffic across multiple VMs.

## Steps I Did:

### 1) Azure Virtual Network Setup
I created a Resource Group named **NetMazeRG** where I planned to deploy the entire project. Then I set up an Azure Virtual Network (VNet) named **NetMazeVNet** in the Canada Central region, with the following subnets:
- **WebAppSubnet:** `10.0.1.0/24`
- **DatabaseSubnet:** `10.0.2.0/24`
- **AdminSubnet:** `10.0.3.0/24`
- **GatewaySubnet:** `10.0.255.0/27` for future VPN connectivity.


![Virtual Network (viii)](https://github.com/user-attachments/assets/682b5a0f-f75f-4146-bb70-3ac1941901d4)


### 2) On-Premises Network Simulation
To simulate the on-premises environment, I deployed another VNet named **OnPremVNet** in the North Central US region, with a **GatewaySubnet** (`10.1.255.0/27`) to connect it with **NetMazeVNet** using a site-to-site VPN.


![OnPremVNet (v)](https://github.com/user-attachments/assets/b7990b9b-3bf7-4c19-9970-d962c395188a)


### 3) Secure Connectivity
I implemented Azure VPN Gateway to create a site-to-site VPN connection between the **OnPremVNet** and **NetMazeVNet**. This included creating:
- **NetMazeVPNGateway** for **NetMazeVNet**
- **OnPremVPNGateway** for **OnPremVNet**
- Local network gateways to represent each environment in the opposite network
- Site-to-site VPN connections: **NetMazeToOnPrem** and **OnPremToNetMaze**.

![Connectivity Test (i)](https://github.com/user-attachments/assets/53db079a-5695-4c95-ac6c-524a2c3299eb)
![Connectivity Test (iii)](https://github.com/user-attachments/assets/bbd867b7-e20e-41ce-ae86-bc5f4ed37e2c)
![Connectivity Test (Ping Successful) (vii)](https://github.com/user-attachments/assets/b4827116-1b39-4742-999d-5001a00aa58c)


### 4) Resource Deployment
I deployed VMs in each subnet:
- **WebAppVM** in **WebAppSubnet** (Windows Server with IIS installed)
- **DatabaseVM** in **DatabaseSubnet** (Ubuntu Server with MySQL installed)
- **AdminVM** in **AdminSubnet** (Windows Server with administrative tools)

![WebAppVM (x)](https://github.com/user-attachments/assets/b56bea2b-c625-4a0e-bc26-84ccd6c65774)
![Connectivity Test](https://github.com/user-attachments/assets/77b799a2-1b8a-45ea-9021-cf4468dcfcea)


### 5) Network Access Control
I created NSGs for each subnet to control inbound and outbound traffic:
- **WebAppNSG:** Allows HTTP/HTTPS traffic to **WebAppVM**
- **DatabaseNSG:** Allows MySQL and SSH traffic to **DatabaseVM**
- **AdminNSG:** Allows RDP and SSH traffic to **AdminVM**


### 6) Secure Administrative Access
I implemented Azure Bastion for secure RDP and SSH access without exposing VMs to the public internet. Bastion services were deployed in both **NetMazeVNet** and **OnPremVNet**.

![Azure Bastion (WebAppVM Connection) (xxi)](https://github.com/user-attachments/assets/e3712297-0e02-495c-9b43-1e2c98cb0e4f)
![Azure Bastion (AdminVM Connection) (xvii)](https://github.com/user-attachments/assets/fd572ac0-3cd7-4ad2-a632-49d4df939486)


### 7) Private Access to Azure PaaS Services
I used Azure Private Link to securely connect to an Azure SQL Database named **NetMazeSQLDB** over a private endpoint within **NetMazeVNet**.

![Azure SQL Database (viii)](https://github.com/user-attachments/assets/5de12f06-6f88-43f4-a4d5-971a4be61fe3)
![Azure Private Link (Connectivity Test) (xii)](https://github.com/user-attachments/assets/a607e531-99f0-4b73-ba45-26f182a62ce2)


### 8) DNS and Load Balancing
I configured Azure DNS with a private DNS zone (`netmaze.local`) and set up an Azure Load Balancer named **NetMazeLoadBalancer** to distribute traffic across VMs in the **WebAppSubnet**.

![Azure Load Balancer (viii)](https://github.com/user-attachments/assets/50d9c1d6-ecd5-4d00-817b-f9df0fce8fe9)
![Verification (DNS) (ii)](https://github.com/user-attachments/assets/d11cbc8a-078c-4809-ade1-323aa0144e39)


### 9) Access Control (Update According to the Project Workflow)
Final NSG updates were made to reflect the correct project workflow, including specific rules for HTTP, HTTPS, and RDP access.


### 10) Performance and Security Testing
I simulated various network scenarios, including:
1. **Checked Load Balancer Functionality:** Tested load balancing between VMs in **WebAppSubnet**.
2. **Tested Data Transition Between On-Premises and Azure:** Verified data transition and connectivity between **OnPremVM** and VMs in **NetMazeVNet**.
3. **Tested Azure-to-Azure Communication:** Verified data transition and connectivity between VMs in **NetMazeVNet**.

![Testing Load Balancer (ii)](https://github.com/user-attachments/assets/1e313cdc-ab35-48ad-ab43-7daaec3016d8)



### Additionally, I validated security configurations through tests like:
- HTTP and SSH access from authorized and unauthorized sources
- Accessing blocked ports
- ICMP (Ping) tests across different VMs


### 11) Monitoring and Auditing
Monitoring and diagnostics were enabled on VPN Gateways, NSGs, SQL Database, and Load Balancer using Azure Monitor and Log Analytics Workspaces. Alerts were set up for unauthorized SSH attempts and VPN Gateway downtime.

![Enable Monitoring on NSGs (viii)](https://github.com/user-attachments/assets/eade1c29-9ea4-4c1a-85fd-80bb43d06393)
![Enable Monitoring on SQL DB (iii)](https://github.com/user-attachments/assets/2d1d1071-1ab8-450d-9f4a-59a5f1733e4a)
![Enable Monitoring on VPN Gateway (v)](https://github.com/user-attachments/assets/44cd8fb0-5fdc-4601-9e37-a96df0eee1ed)
![VPN Gateway Downtime Alert (vii)](https://github.com/user-attachments/assets/479b3f43-3e96-41a4-8d32-73d306fb725a)
![Unauthorized SSH Attempt Alert (viii)](https://github.com/user-attachments/assets/4c61496d-08df-4587-92bd-3ecc146a6ee4)


## Testing
The final phase involved rigorous testing to ensure that all configurations were correct and secure. This included testing the load balancer, data transition between on-premises and Azure, and Azure-to-Azure communication.

## Main Demonstrations (Video)

[![NetMaze Explorer Main Demonstration](https://img.youtube.com/vi/tYM8_nwB4zY/0.jpg)](https://www.youtube.com/watch?v=tYM8_nwB4zY)


## Conclusion
The **NetMazeExplorer** project successfully demonstrated the ability to implement and manage a secure, hybrid networking environment using Azure services. The project showcased comprehensive skills in network configuration, security, monitoring, and performance testing, making it an ideal showcase for networking and cloud computing expertise.

## Skills Demonstrated
- **Hybrid Networking:** Setup of secure hybrid networking environments using Azure VNet, VPN, and Private Link.
- **Security Best Practices:** Implementation of NSGs, Azure Bastion, and private access to ensure a secure network environment.
- **Monitoring and Auditing:** Use of Azure Monitor and NSG Flow Logs for real-time monitoring and security auditing.
- **Resource Management:** Efficient management and deployment of Azure resources with a focus on security and performance.

## Repository Contents
- **Manual:** A detailed manual of 180 Pages documenting each step of the project, including configurations, testing procedures, screenshots and troubleshooting tips.
- **Screenshots:** Visual documentation of key stages and configurations throughout the project, providing a visual guide and reference.
- **Source Code:** All the source code used in this project, including Powershell Scripts, Commands used for Data Transfer etc. organized in the `Source_Code` folder.


## Contact
For any questions or further information, feel free to reach out to me on LinkedIn: [LinkedIn Profile](https://www.linkedin.com/in/vivek-vashisht04/)
