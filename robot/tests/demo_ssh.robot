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