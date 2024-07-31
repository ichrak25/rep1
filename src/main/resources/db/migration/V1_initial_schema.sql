CREATE TABLE configurations (
                                config_id SERIAL PRIMARY KEY,
                                config_name VARCHAR(50),
                                config_data TEXT
);
CREATE TABLE rules (
    rule_id SERIAL PRIMARY KEY,
    source_ip VARCHAR(15),
    destination_ip VARCHAR(15),
    source_port INT,
    destination_port INT,
    protocol VARCHAR(10),
    action VARCHAR(10),
    configuration_id INT,
    FOREIGN KEY (configuration_id) REFERENCES configurations(config_id)
);

CREATE TABLE logs(
    log_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_ip VARCHAR(15),
    destination_ip VARCHAR(15),
    source_port INT,
    destination_port VARCHAR(15),
    protocol VARCHAR(10),
    action VARCHAR(10),
    firewall_rule_id INT,
    FOREIGN KEY (firewall_rule_id) REFERENCES rules(rule_id)
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50)
);


CREATE TABLE network_interfaces(
                                   net_id SERIAL PRIMARY KEY ,
                                   name VARCHAR(50),
                                   ip_address VARCHAR(15),
                                   mac_address VARCHAR(17),
                                   status VARCHAR(20),
                                   configuration_id INT,
                                   FOREIGN KEY (configuration_id) REFERENCES configurations(config_id)
);
CREATE TABLE alerts (
    alert_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    alert_type VARCHAR(50),
    message TEXT,
    network_interface_id INT,
    FOREIGN KEY (network_interface_id) REFERENCES network_interfaces(net_id)
);



CREATE TABLE audit_logs (
    audit_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action VARCHAR(50),
    description TEXT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
