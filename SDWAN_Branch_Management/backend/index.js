const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const { Pool } = require('pg');

// Initialize PostgreSQL connection
const pool = new Pool({
  user: 'admin',
  host: 'localhost',
  database: 'sdwan',
  password: 'password',
  port: 5432,
});

app.use(bodyParser.json());

// Define branch office details and policies in PostgreSQL
const branches = [
  { id: 1, name: 'Branch 1', ip: '192.168.1.1', primaryLink: 'MPLS', backupLink: 'LTE' },
  { id: 2, name: 'Branch 2', ip: '192.168.2.1', primaryLink: 'MPLS', backupLink: 'LTE' },
];

// API to create a policy for a specific branch
app.post('/branch/:id/policy', async (req, res) => {
  const branchId = req.params.id;
  const { latencyThreshold, appPriority } = req.body;

  try {
    await pool.query('INSERT INTO policies (branch_id, latency_threshold, app_priority) VALUES ($1, $2, $3)', 
      [branchId, latencyThreshold, appPriority]);

    // Send policy to branch edge device
    const branch = branches.find(b => b.id == branchId);
    if (branch) {
      // Simulating policy push to branch edge device
      console.log(`Pushing policy to ${branch.name}...`);
      // Use a real HTTP request or MQTT to send the policy
    }
    
    res.status(201).json({ message: 'Policy created and applied successfully.' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Failed to create policy.' });
  }
});

// API to monitor branch performance
app.get('/branch/:id/performance', async (req, res) => {
  const branchId = req.params.id;

  try {
    const { rows } = await pool.query('SELECT * FROM performance WHERE branch_id = $1', [branchId]);
    res.status(200).json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Failed to fetch performance data.' });
  }
});

// Start the server
app.listen(3000, () => {
  console.log('SD-WAN Controller API is running on port 3000.');
});

