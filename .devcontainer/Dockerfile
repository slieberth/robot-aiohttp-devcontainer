FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Installiere zusätzliche Pakete
RUN apt-get update && apt-get install -y curl git python3 python3-pip openssh-server

# Erstelle einen Benutzer für SSH-Login
RUN useradd -ms /bin/bash robot && \
    echo 'robot:robot' | chpasswd

# Erstelle das SSH-Verzeichnis und starte den Dienst beim Containerstart
RUN mkdir /var/run/sshd

# Optional: root-Login verhindern und Passwortauth erlauben (für Sicherheit beim Test)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Robot Framework Tools installieren
RUN pip3 install \
    aiohttp \
    robotframework \
    robotframework-sshlibrary \
    robotframework-requests

# Expose SSH port
EXPOSE 22

# Set entrypoint and default command
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
