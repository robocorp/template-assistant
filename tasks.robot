*** Settings ***
Documentation       An Assistant Robot.

Library             OperatingSystem
Library             RPA.Assistant


*** Tasks ***
Main
    [Documentation]
    ...    The Main task running the Assistant
    ...    Configure your window behaviour here

    Display Main Menu
    ${result}=    RPA.Assistant.Run Dialog
    ...    title=Assistant Template
    ...    on_top=True
    ...    height=450


*** Keywords ***
Display Main Menu
    [Documentation]
    ...    Main UI of the bot. We use the "Back To Main Menu" keyword
    ...    with buttons to make other views return here.
    Clear Dialog
    Add Heading    Assistant Template
    Add Text    Available UI Components:
    Add Button    Static Components    Show Static Components
    Add Button    Input Components    Show Input Components
    Add Button    File Components    Show File Components
    Add Text    Get Started:
    Add Button    Simple Example    Show Example View
    Add Submit Buttons    buttons=Close    default=Close

Back To Main Menu
    [Documentation]
    ...    This keyword handles the results of the form whenever the "Back" button
    ...    is used, and then we return to the main menu
    [Arguments]    ${results}={}

    # Handle the dialog results via the passed 'results' -variable
    # Logging the user outputs directly is bad practice as you can easily expose things that should not be exposed
    IF    'password' in ${results}    Log To Console    Do not log user inputs!
    IF    'files' in ${results}
        Log To Console    Selected files: ${results}[files]
    END

    Display Main Menu
    Refresh Dialog

Show Static Components
    [Documentation]    Action shows all text, image and icon components

    Clear Dialog
    Add Heading    Big heading    Large
    Add Heading    Small heading    Small
    Add Text    This is normal text
    Add Text    This is small text    Small

    Add Image    ${CURDIR}${/}mark.png

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

    Clear Dialog
    Add Heading    Input handling

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

    Add Slider
    ...    name=percentage
    ...    slider_min=0
    ...    slider_max=100
    ...    thumb_text={value}%
    ...    steps=100

    Add Checkbox    checkbox    This is a checkbox    True
    Add Hidden Input    hidden_field    This is hidden

    Add Next Ui Button    Back    Back To Main Menu
    Refresh Dialog

Show File Components
    [Documentation]    Action shows all file input components

    Clear Dialog
    Add Heading    File handling

    Add File    ${CURDIR}    label=Current
    Add File Input    files    Choose multiple files...    file_type=md,png    multiple=True
    Add Files    *.png

    Add Next Ui Button    Back    Back To Main Menu

    Refresh Dialog

Show Example View
    [Documentation]
    ...    A clean example view to get started
    ...    Contains a single action that demonstrates error handling

    Clear Dialog    # We clear the current view when starting to create another view
    Add Heading    Example with error handling
    Add Text    The action below causes an error, but we only log it and continue.
    # A button that calls a keyword that fails
    Add Button    Get Image - Error handling    Get Data

    # We use "Add Next Ui Button" keyword to generate a back button, that will pass the ${results}
    # of the dialog to the keyword "Back To Main Menu"
    Add Next Ui Button    Back    Back To Main Menu
    Refresh Dialog

Get Data
    [Documentation]    Example of exception handling

    TRY
        # This action fails to demostrate the exception handling
        Get File    notfound.png
    EXCEPT    message
        # Handle the exceptions here and perform the actions you want
        # You can create an error view and jump to there, etc.
        Log    Handling Get Data error case
    FINALLY
        # In this case we just want to continue running the assistant, so we return to the main view
        Back To Main Menu
    END
