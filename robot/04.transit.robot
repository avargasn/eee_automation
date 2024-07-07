*** Settings ***
Library    SSHLibrary

*** Variables ***
@{HOSTS}  
    ...    10.0.137.1    #BB1
    ...    10.0.137.2    #BB2
    ...    10.0.137.3    #BB3
    ...    10.0.137.4    #BB4
    ...    10.0.137.9    #M9
    ...    10.0.137.10   #M10
${USERNAME}    admin
${PASSWORD}    admin
${DEVICE_TYPE}    arista_eos
${JUMPSERVER}    192.168.86.3
${VLAN}    50

*** Keywords ***
Open Connection and Log In
    [Arguments]    ${HOST}
    Open Connection    ${HOST}
    Login              ${USERNAME}    ${PASSWORD}    proxy_cmd=ssh -l root -i ~/.ssh/id_rsa -W ${HOST}:22 ${JUMPSERVER}

Check Mac Address Table
    ${show_mac_address_table}=    Execute Command    show mac address-table dynamic vlan ${VLAN}
    ${count_dynamic_mac_address}=   Get Count    ${show_mac_address_table}    DYNAMIC
    # Should Be Equal    ${count_dynamic_mac_address}    3
    Should Be Equal As Integers    ${count_dynamic_mac_address}    6

*** Test Cases ***
Validate Mac Address Table Size on VLAN ${VLAN} (Transit Service)
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Check Mac Address Table
        Close All Connections
    END
