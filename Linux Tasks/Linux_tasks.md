# Custom Apache User Setup
  # Requirement:
    In response to heightened security concerns, the xFusionCorp Industries security team has opted for custom Apache users for their web applications. Each user is tailored specifically for an application, enhancing security measures. Your task is to create a custom Apache user according to the outlined specifications:

            a. Create a user named ravi on App server 3 within the Stratos Datacenter.
            b. Assign a unique UID 1102 and designate the home directory as /var/www/ravi.
  # Solution:
        [banner@stapp03 ~]$ useradd  -u 1102 -d /var/www/ravi -m ravi  -- Command to create the user with UID and Customisied directory path
        useradd: Permission denied.
        useradd: cannot lock /etc/passwd; try again later.
        [banner@stapp03 ~]$ sudo useradd  -u 1102 -d /var/www/ravi -m ravi 

        We trust you have received the usual lecture from the local System
        Administrator. It usually boils down to these three things:

            #1) Respect the privacy of others.
            #2) Think before you type.
            #3) With great power comes great responsibility.

        [sudo] password for banner: 
        [banner@stapp03 ~]$ cat /etc/passwd 
        ravi:x:1102:1102::/var/www/ravi:/bin/bash
        [banner@stapp03 ~]$ 