# 🧪 Robot Framework Devcontainer Demo

This repository demonstrates how to use [**Devcontainers**](https://containers.dev/) for developing and testing Python applications with **Robot Framework**, **aiohttp**, and an integrated **SSH server**.

The goal is to provide a fully isolated development environment that makes it easy and reproducible to test network services (HTTP & SSH) — locally or in the cloud (e.g., via GitHub Codespaces).

---

## 🛠 Features

- ✅ Preconfigured Devcontainer (Ubuntu + Python + SSH)
- ✅ A simple `aiohttp` web server (`server.py`)
- ✅ Robot Framework with `SSHLibrary`, `RequestsLibrary`, and `Process`
- ✅ Automatic startup of SSH server inside the container (`entrypoint.sh`)
- ✅ Sample test cases for HTTP and SSH login

---

## 🚀 Quickstart (local with VS Code)

### Prerequisites

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/robot-aiohttp-devcontainer.git
cd robot-aiohttp-devcontainer
```

### 2. Open it with VS Code

```bash
code .
```

VS Code should prompt you to reopen the folder in a Devcontainer.

### 3. Run your tests

```bash
robot robot/tests/
```

Or run a specific test file:

```bash
robot robot/tests/aiohttp_server_test.robot
```

---

## 🧩 Project Structure

```text
.devcontainer/
├── devcontainer.json      # Devcontainer setup
├── Dockerfile             # Base image with Python, pip, SSH server, etc.
├── entrypoint.sh          # Starts the SSH service

robot/
├── tests/
│   ├── aiohttp_server_test.robot
│   └── ssh_login_test.robot
server.py                  # aiohttp web server for testing
README.md                  # This file 😉
```

---

## 🌐 Web Server (aiohttp)

The included `server.py` starts a simple `aiohttp` web server with these endpoints:

- `GET /` → `{"message": "Hello, world!"}`
- `GET /user/<name>` → `{"greeting": "Hello, <name>!"}`
- `POST /echo` → returns the posted JSON back

To run it:

```bash
python3 server.py
```

---

## 🔐 SSH Test Server

The Devcontainer includes a real OpenSSH server which starts automatically. You can access it like this:

- Host: `localhost`
- Port: `2222` (mapped via `-p 2222:22`)
- Username: `robot`
- Password: `robot`

Example:

```bash
ssh robot@localhost -p 2222
```

---

## 🧪 Example Robot Test: SSH Login

```robot
*** Settings ***
Library    SSHLibrary

*** Test Cases ***
Login To SSH Server
    Open Connection    localhost    port=2222
    Login              robot    robot
    ${whoami}=         Execute Command    whoami
    Should Be Equal    ${whoami}    robot
    Close Connection
```

---

## ❤️ Why Devcontainers?

- Reproducible environment for all developers
- No local Python or dependencies needed
- Easily runs in GitHub Codespaces
- Perfect for training, demos, CI/CD, and experimentation

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## ✨ Credits

Created by Stefan to showcase a modern, test-driven Devcontainer setup using Robot Framework and Python.
