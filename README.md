# **SD-WAN Branch Office Connectivity Management Tool**

## **Overview**

The **SD-WAN Branch Office Connectivity Management Tool** is a centralized web application built to manage the network connectivity of multiple branch offices using Software-Defined Wide Area Networking (SD-WAN). It allows network administrators to create, apply, and monitor traffic policies across branch offices, ensuring optimal performance, security, and failover capabilities.

This tool leverages **FlexiWAN** for SD-WAN orchestration and offers a front-end dashboard for ease of use and real-time monitoring.

---

## **Project Structure**

```plaintext
SDWAN_Branch_Management/
├── backend/                  # Node.js API for managing branch policies and performance
│   ├── config/               # Database configuration (PostgreSQL)
│   ├── controllers/          # Controllers for handling API logic
│   ├── models/               # Database models for branch, policy, and performance data
│   ├── routes/               # API routes for managing branches and policies
│   └── index.js              # Main entry point for the backend API (Express.js)
├── frontend/                 # React.js application for the admin dashboard
│   ├── public/               # Public assets for the front-end
│   └── src/                  # Source code for React components
│       ├── components/       # Dashboard component for managing branches and policies
│       ├── App.js            # Main React app
│       └── index.js          # React entry point
├── database/                 # SQL scripts for database schema setup
│   └── create_tables.sql     # PostgreSQL table schema for branches, policies, and performance
├── docs/                     # Documentation folder (API specs, etc.)
└── README.md                 # Project overview and instructions
```

---

## **Current Features**

### 1. **Centralized Branch Management**
   - Create, view, and manage branch office network details (e.g., IP addresses, primary and backup links).
   - Define and apply network policies (e.g., latency thresholds, application priorities) to each branch.

### 2. **Policy-Based Routing**
   - Set application-aware routing policies for each branch, allowing prioritization of critical traffic like VoIP and video conferencing.
   - Policies include customizable thresholds for latency and application-based traffic management.

### 3. **Dynamic Path Selection and Failover**
   - Automatically reroute traffic based on network performance metrics like latency, jitter, and packet loss.
   - Multi-link failover support between MPLS, LTE, and broadband.

### 4. **Secure Communication**
   - Set up secure encrypted tunnels (IPSec/WireGuard) between the central office and branches, ensuring data integrity and confidentiality.

### 5. **Real-Time Performance Monitoring**
   - Continuously monitor the performance of each branch's network links, with data on latency, packet loss, and jitter.
   - Performance data can be accessed through API endpoints.

### 6. **Dashboard for Policy Management**
   - User-friendly React.js dashboard for managing branch policies, applying changes, and monitoring real-time performance metrics.
   - Allows administrators to quickly select a branch, apply routing policies, and monitor the network.

---

## **Setup Instructions**

### **Backend (Node.js) Setup**
1. **Install dependencies:**
   ```bash
   cd backend
   npm install
   ```

2. **Configure PostgreSQL:**
   - Edit the database configuration in `backend/config/db.js` to match your local PostgreSQL setup.

3. **Create the database tables:**
   ```bash
   psql -U <your-username> -d <your-database> -f database/create_tables.sql
   ```

4. **Start the backend server:**
   ```bash
   npm start
   ```

   The backend API will run on `http://localhost:3000`.

### **Frontend (React.js) Setup**
1. **Install dependencies:**
   ```bash
   cd frontend
   npm install
   ```

2. **Start the frontend server:**
   ```bash
   npm start
   ```

   The frontend dashboard will be available at `http://localhost:3000`.

---

## **API Endpoints**

### **Branch Management**
- **POST /branch/:id/policy**: Apply a policy to a branch based on its ID.
- **GET /branch/:id/performance**: Retrieve real-time performance metrics for a branch.

### **Performance Monitoring**
- **GET /performance/:branch_id**: Retrieve performance data for a specific branch (latency, packet loss, jitter).

---

## **Future Features**

### 1. **Advanced AI-Driven Path Optimization**
   - Leverage AI/ML to predict network congestion and dynamically optimize routing based on historical traffic patterns.
   - Recommend proactive changes to routing policies to avoid potential issues.

### 2. **QoS and Traffic Shaping**
   - Introduce more advanced Quality of Service (QoS) policies, allowing traffic shaping and bandwidth management for different application types.
   - Implement fine-grained traffic prioritization for different applications (e.g., critical apps like VoIP vs. bulk data transfer).

### 3. **Network Visualization**
   - Add a network topology map to visualize the physical and logical layout of all branch connections.
   - Use real-time performance metrics to show the health and status of each link.

### 4. **Automated Alerts and Notifications**
   - Introduce email, SMS, or Slack notifications for critical events (e.g., link failovers, high latency, packet loss).
   - Configurable thresholds for alerting when network performance degrades.

### 5. **Multi-Cloud SD-WAN Integration**
   - Expand the tool to support SD-WAN management across multi-cloud environments (AWS, Azure, Google Cloud).
   - Secure interconnects between branches and cloud resources, with dynamic routing based on cloud performance.

### 6. **Mobile Device Integration for Field Teams**
   - Extend SD-WAN management to support mobile workers and field teams with dynamic routing over cellular and satellite networks.
   - Real-time optimization for mobile traffic and secure connectivity for field devices.

### 7. **Load Balancing and Redundancy**
   - Add support for load balancing across multiple WAN links (MPLS, broadband, 5G) to improve bandwidth utilization.
   - Redundant connectivity with intelligent traffic splitting based on real-time performance.

### 8. **User Access and Role-Based Permissions**
   - Introduce a role-based access control system to manage who can view and modify SD-WAN policies.
   - Allow different levels of access for network engineers, admins, and auditors.

### 9. **Detailed Historical Reporting**
   - Store historical performance data and generate detailed reports on network health and performance trends over time.
   - Include visual graphs and metrics to help administrators analyze long-term network behavior.

### 10. **Integration with Third-Party Security Tools**
   - Integrate with firewalls and IDS/IPS systems to ensure that all network traffic complies with security policies.
   - Introduce network segmentation to separate traffic based on security classifications.


---

### **MPLS and SD-WAN Routing Overview**

```plaintext
         +-------------------------------------------------------+
         |                        Internet                       |
         +---------------------------+---------------------------+
                                     |
                                     |
                         +-----------------------+
                         |       SD-WAN          |  
                         |      Controller       |   
                         | (Policy & Path Mgmt)  |
                         +-----------------------+
                                     |
      +------------------------------+------------------------------+
      | MPLS Link              (SD-WAN Tunnel)                  Broadband/LTE Link
+---------------------+                                   +---------------------+
|     Branch A        |------ MPLS (WAN) Tunnel --------->|     Branch B        |
|   (Edge Router)     |                                   |   (Edge Router)     |
+---------------------+                                   +---------------------+
      |                                                        |
      |                                                        |
+---------------------+                                   +---------------------+
|   Applications      |                                   |   Applications      |
| - VoIP              |                                   | - VoIP              |
| - Video Conferencing|                                   | - Video Conferencing|
| - Cloud Access      |                                   | - Cloud Access      |
+---------------------+                                   +---------------------+

           +------------------------------------------------------------------+
           |                         MPLS NETWORK                             |
           |  - Low-latency, reliable WAN link for critical applications       |
           |  - Dedicated paths based on labels (no traditional IP routing)    |
           |  - Enforces QoS (Quality of Service) for traffic prioritization   |
           |  - Used for latency-sensitive apps like VoIP and Video Conferencing|
           +------------------------------------------------------------------+
                                     |
      +------------------------------+------------------------------+
                                     |
                         +-----------------------+
                         |  Public WAN Links     |  
                         | (Broadband, LTE/5G)   |   
                         +-----------------------+
      +------------------------------+------------------------------+
      |                                                        |
      |                                                        |
+---------------------+                                   +---------------------+
|     Branch A        |                                   |     Branch B        |
|   (Edge Router)     |------ Broadband/LTE Path -------->|   (Edge Router)     |
+---------------------+                                   +---------------------+

           +------------------------------------------------------------------+
           |                       PUBLIC WAN LINKS                           |
           |  - Broadband and LTE/5G connections used for general traffic      |
           |  - Lower cost and higher capacity than MPLS, but with variable    |
           |    reliability and latency.                                       |
           |  - Suitable for general business applications and bulk data      |
           |    transfers.                                                    |
           +------------------------------------------------------------------+
```

---

### **Explanation of Key Concepts**

#### **MPLS (Multi-Protocol Label Switching)**
- **MPLS** is a type of WAN technology that routes traffic based on short path labels rather than traditional IP addresses. This creates dedicated, reliable paths for data across a network.
- **Usage**: MPLS is typically used for **latency-sensitive applications** like **VoIP**, **video conferencing**, and **real-time data** transmission.
- **QoS (Quality of Service)**: MPLS enforces QoS to ensure that critical applications get priority over less critical traffic.

#### **Public WAN Links (Broadband, LTE/5G)**
- These links are used for more general-purpose traffic. They are often **cheaper** and **more scalable** than MPLS but come with **higher latency** and **less guaranteed reliability**.
- **Usage**: Ideal for **bulk data transfers**, **cloud access**, and **general business applications** that do not require low latency or guaranteed bandwidth.

#### **SD-WAN Controller**
- The **SD-WAN Controller** plays a critical role in managing traffic across **multiple WAN links** (such as MPLS, broadband, and LTE).
- It ensures **dynamic path selection**, allowing traffic to be routed across the best available link based on real-time metrics such as **latency**, **packet loss**, and **jitter**.
- The controller is responsible for applying **policies** to ensure that critical applications use high-quality links (like MPLS), while non-critical traffic can use public broadband or LTE.

---

### **Dynamic Path Selection**

The **SD-WAN Controller** constantly monitors the performance of the available WAN links (MPLS, Broadband, LTE) and makes routing decisions based on the policies set by network administrators.

- **High-priority applications** (e.g., VoIP or Video) are sent over MPLS links when the latency and performance are within acceptable limits.
- If the MPLS link becomes degraded (due to high latency or packet loss), the **SD-WAN controller** can reroute the traffic through an alternate path, such as **broadband** or **LTE**.
- **General applications** (e.g., web traffic, email, file transfers) are usually routed over the cheaper broadband links, keeping MPLS free for high-priority traffic.

---

### **UML Deployment Diagram**

```plaintext
                +---------------------------+
                |         Controller         |
                |    (SD-WAN Central Node)   |
                +---------------------------+
                     /      |      \      
                    /       |       \
                   /        |        \
                  /         |         \
    +------------------+   +------------------+   +------------------+
    |     Edge Router   |   |     Edge Router   |   |     Edge Router   |
    |   (Branch A Site) |   |   (Branch B Site) |   |   (Branch C Site) |
    +------------------+   +------------------+   +------------------+
           |    |               |    |               |    |
           |    |               |    |               |    |
     MPLS  |    | Broadband/LTE  |    | MPLS          |    | Broadband/LTE
    +------+    +----------------+    +---------------+    +------------+
    | MPLS Backbone / Public WAN (Internet, LTE, 5G)                         |
    +-----------------------------------------------------------------------+
```

---

### **Key Points in SD-WAN Deployment**

1. **Controller**: The SD-WAN controller manages all branches and applies policies for traffic routing and path selection. It connects branches through multiple WAN links, providing seamless connectivity.
   
2. **Edge Routers**: These are the devices deployed at each branch, managing local traffic and communicating with the controller. They route traffic based on the dynamic policies received from the controller.

3. **Multiple WAN Links**:
   - **MPLS** is used for high-priority traffic due to its reliability and low-latency properties.
   - **Broadband and LTE** provide additional, cheaper connectivity options for less critical traffic or for failover when MPLS performance degrades.

---

## **Contributing**

Contributions are welcome! Please follow the guidelines below:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature XYZ"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Create a pull request and explain your changes.

---

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## **Contact**

For any questions or support regarding this project, feel free to reach out:

- Project Maintainer: Shane Trimbur [shanetrimbur@gmail.com]

