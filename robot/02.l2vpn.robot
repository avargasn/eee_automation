*** Settings ***
Library    SSHLibrary

*** Variables ***
@{HOSTS}  
    ...    10.0.137.1    #BB1
    ...    10.0.137.7    #M7
    ...    10.0.137.12   #M12
${USERNAME}    admin
${PASSWORD}    admin
${DEVICE_TYPE}    arista_eos
${JUMPSERVER}    192.168.86.3
${VLAN}    100

*** Keywords ***
Open Connection and Log In
    [Arguments]    ${HOST}
    Open Connection    ${HOST}
    Login              ${USERNAME}    ${PASSWORD}    proxy_cmd=ssh -l root -i ~/.ssh/id_rsa -W ${HOST}:22 ${JUMPSERVER}

Check Mac Address Table
    ${SHOW_MAC_ADDRESS_TABLE}=    Execute Command    show mac address-table dynamic vlan ${VLAN}
    ${COUNT_DYNAMIC_MAC_ADDRESS}=   Get Count    ${SHOW_MAC_ADDRESS_TABLE}    DYNAMIC
    Should Be Equal As Integers    ${COUNT_DYNAMIC_MAC_ADDRESS}    3

*** Test Cases ***
Validate Mac Address Table Size on VLAN ${VLAN} (L2VPN Service)
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Check Mac Address Table
        Close All Connections
    END
