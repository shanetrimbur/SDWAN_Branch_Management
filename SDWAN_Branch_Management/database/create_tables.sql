CREATE TABLE branches (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    ip VARCHAR(50),
    primary_link VARCHAR(50),
    backup_link VARCHAR(50)
);

CREATE TABLE policies (
    id SERIAL PRIMARY KEY,
    branch_id INT REFERENCES branches(id),
    latency_threshold INT,
    app_priority VARCHAR(100)
);

CREATE TABLE performance (
    id SERIAL PRIMARY KEY,
    branch_id INT REFERENCES branches(id),
    latency INT,
    jitter INT,
    packet_loss FLOAT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
