# Create a dedicated user
sudo useradd --no-create-home --shell /bin/false node_exporter

# Download the latest Node Exporter release
# Go to the /tmp directory:
cd /tmp

# Then download the latest version:
curl -LO https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.9.1-linux-amd64.tar.gz

# Unpack it:
tar xvf node_exporter-1.9.1-linux-amd64.tar.gz
cd node_exporter-1.9.1-linux-amd64

# Move the binary to your system path
sudo mv node_exporter /usr/local/bin/

# Verify installation:
node_exporter --version

# Set correct permissions
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Create a systemd service file
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF
# Reload systemd and start the service
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter
