*** Settings ***
Suite Setup     Setup
Suite Teardown  Teardown
Test Teardown   Test Teardown
Resource        ${RENODEKEYWORDS}

*** Test Cases ***
Should Receive A Message
    ${agent}=                   Start Process		${CURDIR}/../renode/start_agent.sh    ${CURDIR}/../renode 	shell=True  stdout=${CURDIR}/../renode/frist_out.txt    stderr=${CURDIR}/../renode/first_err.txt
    Execute Script              ${CURDIR}/../renode/first_instance.resc
    Create Terminal Tester      sysbus.usart1
    Create Terminal Tester      sysbus.usart2
    Start Emulation
    Wait For Line On Uart       Data frame .{1,}  30  1  treatAsRegex=true
    Sleep                       10
    Terminate Process           ${agent}
