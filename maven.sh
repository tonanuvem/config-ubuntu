#!/bin/sh
set -e

# script to install maven

# todo: add method for checking if latest or automatically grabbing latest
mvn_version=${mvn_version:-3.6.3}
url="http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/${mvn_version}/binaries/apache-maven-${mvn_version}-bin.tar.gz"
install_dir="/opt/maven"

if [ -d ${install_dir} ]; then
    sudo mv ${install_dir} ${install_dir}.$(date +"%Y%m%d")
fi

sudo mkdir ${install_dir}
curl -fsSL ${url} | tar zx --strip-components=1 -C ${install_dir}

#cat << EOF > /etc/profile.d/maven.sh
sudo cat >> /etc/environment <<EOF
export MAVEN_HOME=${install_dir}
export M2_HOME=${install_dir}
export M2=${install_dir}/bin
export PATH=${install_dir}/bin:$PATH
EOF

#source /etc/profile.d/maven.sh
source /etc/environment

echo maven installed to ${install_dir}
mvn --version

#printf "\n\nTo get mvn in your path, open a new shell or execute: source /etc/profile.d/maven.sh\n"
