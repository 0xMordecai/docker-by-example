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
sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus
