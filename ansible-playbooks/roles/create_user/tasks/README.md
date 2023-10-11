## create_user ansible role
 - This role will create a new user with the username specified in the username variable.

 - The password for this user will be randomly generated using the password lookup plugin.
 
 - The user’s default shell will be /bin/bash, and a home directory will be created for them.
 
 - The user’s comment or description field will be set to “Public kiosk user”.