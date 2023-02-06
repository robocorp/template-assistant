*** Settings ***
Documentation       An Assistant Robot.

Library    RPA.Assistant

*** Variables ***
${CLOSE_ASSISTANT}=   False

*** Tasks ***
Main
    [Documentation]    The main loop just runs the assistant dialog until stopped
    TRY
        WHILE    True   limit=None
            Show Main View
            IF    ${CLOSE_ASSISTANT}  
                BREAK
            END
        END
    EXCEPT    message
        Log    Handle assistant level exceptions here
    FINALLY
        Log    Cleanups as needed
    END

*** Keywords ***

Show Main View
    [Documentation]
    ...    The execution always returns to the main view.
    ...    This is a good location to handle the results.

    Display Main Menu    True
    ${result}=     RPA.Assistant.Run dialog
    ...    title=Assistant Example
    ...    on_top=True

    # Handle the dialog results via the returned 'result' -variable
    Log To Console    ${result}
    
    # Check if the assistant run should exit
    Check Assistant Exit      ${result}
    


Display Main Menu
    [Arguments]    ${first_run}=False
    Clear Elements
    Add Heading   The action Assistant
    Add Button    Simple Components      Show Simple Components
    Add Button    Input Components       Show Input Components
    Add Button    File Components        Show File Components
    Add submit buttons    buttons=Close   default=Close
    
    IF    ${first_run} != True
        Refresh Dialog
    END

Show Simple Components
    [Documentation]    Action shows all text, image and icon components

    Clear elements
    Add heading    Big heading       Large
    Add heading    Small heading     Small
    Add text       Text  
    Add text       Small text        Small

    Add image      ${CURDIR}${/}mark.png   200

    Add icon      Success    size=16
    Add icon      Warning    size=16
    Add icon      Failure    size=16

    Add checkbox  checkbox    This is a checkbox    True

    Add link       
    ...    https://robocorp.com/docs/control-room/attended      
    ...    Attended Automations

    Add submit buttons    buttons=Back   default=Back
    Refresh Dialog

 Show Input Components
    [Documentation]    Action shows all input components

    Clear elements
    Add Text Input           text_input        This is a text input
    Add password input       password          This is a secret

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
    
    Add hidden input   hidden_field   This is hidden

    Add submit buttons    buttons=Back   default=Back
    Refresh Dialog

Show File Components
    [Documentation]    Action shows all file input components

    Clear elements

    Add file    ${CURDIR}    label=Current 
    Add file input    name=types     file_type=PDF files (*.pdf)
    Add files    *.png

    Add submit buttons    buttons=Back   default=Back
    Refresh Dialog

Check Assistant Exit
    [Documentation]    Checks the conditions to exit the assistant run
    [Arguments]    ${result}

    # Dialog result is empty if the Window was just closed forcefully
    ${length} =  Get Length  ${result}
    IF   ${length} != 0
        IF    "${result}[submit]" != "Close" 
            RETURN
        END 
    END

    # Dialog submit action 'Close' is considered as the normal exit command
    Set Global Variable    ${CLOSE_ASSISTANT}    True 