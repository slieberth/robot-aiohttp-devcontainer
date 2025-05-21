*** Settings ***
Library    Process
Library    RequestsLibrary

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