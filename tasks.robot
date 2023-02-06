*** Settings ***
Documentation       An Assistant Robot.

Library    RPA.Assistant


*** Tasks ***
Assistant Main Task
    TRY
        Show Main View
    EXCEPT    message
        Log    Report exception to Control Room here 
    FINALLY
        Log    Cleanups as needed
    END


*** Keywords ***

Show Main View
    [Documentation]
    ...    Good practice to contain the main handling view of your Assistant

    Show All UI Components
    ${result}=     Run dialog    
    ...    title=Assistant Example
    ...    on_top=True

    Refresh Dialog

    # Handle the dialog results via the returned 'result' -variable
    Log    ${result}
    Log To Console    ${result}

Show All UI Components
    [Documentation]
    ...    Action just shows all different UI components available in 
    ...    RPA.Assistant -library

    Clear elements
    Add heading              Big heading       Large
    Add heading              Small heading     Small
    Add text                 Text  
    Add text                 Small text        Small

    Add image                ${CURDIR}${/}mark.png   200

    Add Text Input           text_input        This is a text input
    Add password input       password          This is a secret
    Add checkbox             checkbox          This is a checkbox    True

    Add drop-down
    ...    name=user_type
    ...    options=Admin,Maintainer,Operator
    ...    default=Admin
    ...    label=Drop-down

    Add radio buttons
    ...    name=radio_button
    ...    options=Option A,Option B, Option C
    ...    default=Option A
    ...    label=Radio Buttons
    
    Add icon    Success    size=16
    Add icon    Warning    size=16
    Add icon    Failure    size=16

    #Add link       
    #...    https://robocorp.com/docs/control-room/attended      
    #...    Attended Automations

    #Add file    ${CURDIR}    label=Current 
    #Add file input    name=types     file_type=PDF files (*.pdf)

    Add hidden input   hidden_field   This is hidden

    Add submit buttons    buttons=Close   default=Close
    