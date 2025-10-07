# Create a dedicated user
sudo useradd --no-create-home --shell /bin/false node_exporter

# Download the latest Node Exporter release
# Go to the /tmp directory:
cd /tmp

# Then download the latest version:
curl -LO https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.9.1-linux-amd64.tar.gz
