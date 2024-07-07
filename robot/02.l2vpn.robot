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
    ${show_mac_address_table}=    Execute Command    show mac address-table dynamic vlan ${VLAN}
    ${count_dynamic_mac_address}=   Get Count    ${show_mac_address_table}    DYNAMIC
    # Should Be Equal    ${count_dynamic_mac_address}    3
    Should Be Equal As Integers    ${count_dynamic_mac_address}    3

*** Test Cases ***
Validate Mac Address Table Size on VLAN ${VLAN} (L2VPN Service)
    FOR    ${HOST}    IN    @{HOSTS}
        Log    Executing tests for host: ${HOST}
        Run Keyword And Continue On Failure    Open Connection and Log In    ${HOST}
        Run Keyword And Continue On Failure    Check Mac Address Table
        Close All Connections
    END
