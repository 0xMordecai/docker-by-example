# Download the latest Prometheus binary
cd /tmp
wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-3.5.0-linux-amd64.tar.gz

# Unpack it:
tar xvf prometheus-3.5.0-linux-amd64.tar.gz
cd prometheus-3.5.0-linux-amd64

# Move binaries to system path
sudo mv prometheus promtool /usr/local/bin/

# Verify installation:
prometheus --version

# Create directories and user
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus /var/lib/prometheus
# update the permissions so that two folders are own by prometheus user that we created
sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus

# Move config files
sudo mv consoles/ console_libraries/ prometheus.yml /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus

# Create a systemd service file
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Start Prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
