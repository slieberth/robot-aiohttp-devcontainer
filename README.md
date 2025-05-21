# 🧪 Robot Framework Devcontainer Demo

This repository demonstrates how to use [**Devcontainers**](https://containers.dev/) for developing and testing Python applications with **Robot Framework**, **aiohttp**, and an integrated **SSH server**.

The goal is to provide a fully isolated development environment that makes it easy and reproducible to test network services (HTTP & SSH) — locally or in the cloud (e.g., via GitHub Codespaces).

---

## 🛠 Features

- ✅ Preconfigured Devcontainer (Ubuntu + Python + SSH)
- ✅ A simple `aiohttp` web server (`aiohttp_server.py`)
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
code/
└── aiohttp_server.py       # aiohttp web server

robot/
├── log/                    # Test output/log files
└── tests/                  # Robot Framework test cases
    ├── aiohttp_server_test.robot
    └── demo_ssh.robot

LICENSE
README.md
```

---

## 🌐 Web Server (aiohttp)

The included `aiohttp_server.py` starts a simple `aiohttp` web server with these endpoints:

- `GET /` → `{"message": "Hello, world!"}`
- `GET /user/<name>` → `{"greeting": "Hello, <name>!"}`
- `POST /echo` → returns the posted JSON back

To run it:

```bash
python3 code/aiohttp_server.py
```

---

## 🔐 SSH Test Server

The Devcontainer includes a real OpenSSH server which starts automatically. You can access it like this:

- Host: `localhost`
- Port: `2232` (mapped via `-p 2232:22`)
- Username: `robot`
- Password: `robot`

Example:

```bash
ssh robot@localhost -p 2232
```

---

## 🧪 Example Robot Test: SSH Login

```robot
*** Settings ***
Library    SSHLibrary

*** Variables ***
${HOST}      localhost
${PORT}      22
${USER}      robot
${PASSWORD}  robot

*** Test Cases ***
Login To Devcontainer SSH
    Open Connection    ${HOST}    port=${PORT}
    Login              ${USER}    ${PASSWORD}
    ${output}=         Execute Command    whoami
    Should Contain     ${output}    robot
    Close Connection
```

---

## 🧪 Example Robot Test: Test Aiohttp Server

```robot

*** Variables ***
${SERVER_FILE}    code/aiohttp_server.py
${SERVER_PORT}    8080

*** Test Cases ***
Start And Test Aiohttp Server
    [Setup]    Start Server
    Create Session    local    http://localhost:${SERVER_PORT}
    ${resp}=    GET On Session    local    /
    Log To Console    ${resp}
    Should Be Equal As Strings    ${resp.json()['message']}    Hello, world!
    [Teardown]    Stop Server

*** Keywords ***
Start Server
    Start Process    python3    ${SERVER_FILE}
    Sleep    1s

Stop Server
    Terminate All Processes
```

---

## ❤️ Why Devcontainers?

- Reproducible environment for all developers
- No local Python or dependencies needed
- Easily runs in GitHub Codespaces
- Perfect for training, demos, CI/CD, and experimentation

---

## 📄 License

This project is licensed under the Apache License 2.0

---

## ✨ Credits

Created by Stefan to showcase a modern, test-driven Devcontainer setup using Robot Framework and Python.
