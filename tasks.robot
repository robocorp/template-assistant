*** Settings ***
Documentation       An Assistant Robot.

Library             RPA.Assistant
Library             OperatingSystem


*** Tasks ***
Main
    [Documentation]    The Main Ui
    Set Log Level    WARN

    Display Main Menu
    ${result}=    RPA.Assistant.Run Dialog
    ...    title=Assistant Example
    ...    on_top=True


*** Keywords ***
Display Main Menu
    [Documentation]
    ...    Main UI of the bot. We use the "Back To Main Menu" keyword
    ...    with buttons to make other views return here.
    Clear Elements
    Add Heading    The action Assistant
    Add Button    Static Components    Show Static Components
    Add Button    Input Components    Show Input Components
    Add Button    File Components    Show File Components
    Add Button    Simple Example    Show Example View
    Add Submit Buttons    buttons=Close    default=Close

Back To Main Menu
    [Documentation]
    ...    This keyword handles the results of the form whenever the "Back" button
    ...    is used, and then we return to the main menu
    [Arguments]    ${results}

    # Handle the dialog results via the passed 'results' -variable
    Log To Console    ${results}

    Display Main Menu
    Refresh Dialog

Show Example View
    [Documentation]    Example view
    Clear Elements    # We clear the current view when starting to create another view

    # UI code, Add Heading, Add Text, etc.
    Add Button    Get Image    Get Image

    # We use "Add Next Ui Button" keyword to generate a back button, that will pass the ${results}
    # of the dialog to the keyword "Back To Main Menu"
    Add Next Ui Button    Back    Back To Main Menu
    Refresh Dialog

Get Image
    [Documentation]    Example button function that handles error

    TRY
        Get File    mark01.png
    EXCEPT    message
        Log    send exception to cloud
    FINALLY
        Back To Main Menu    {error: }
    END

Show Static Components
    [Documentation]    Action shows all text, image and icon components

    Clear Elements
    Add Heading    Big heading    Large
    Add Heading    Small heading    Small
    Add Text    Text
    Add Text    Small text    Small

    Add Image    ${CURDIR}${/}mark.png    200

    Add Icon    Success    size=16
    Add Icon    Warning    size=16
    Add Icon    Failure    size=16

    Add Link
    ...    https://robocorp.com/docs/control-room/attended
    ...    Attended Automations

    Add Next Ui Button    Back    Back To Main Menu

    Refresh Dialog

Show Input Components
    [Documentation]    Action shows all input components

    Clear Elements
    Add Text Input    text_input    This is a text input
    Add Password Input    password    This is a secret

    Add Drop-down
    ...    name=user_type
    ...    options=Admin,Maintainer,Operator
    ...    default=Admin
    ...    label=Drop-down

    Add Radio Buttons
    ...    name=radio_button
    ...    options=Option A,Option B, Option C
    ...    default=Option A
    ...    label=Radio Buttons
    ...

    Add Checkbox    checkbox    This is a checkbox    True

    Add Hidden Input    hidden_field    This is hidden

    Add Next Ui Button    Back    Back To Main Menu

    Refresh Dialog

Show File Components
    [Documentation]    Action shows all file input components

    Clear Elements

    Add File    ${CURDIR}    label=Current
    Add File Input    name=types    file_type=PDF files (*.pdf)
    Add Files    *.png

    Add Next Ui Button    Back    Back To Main Menu

    Refresh Dialog
