# Pleroma CI/CD pipeline

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/pleroma"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Deploy Pleroma server with CI/CD on Elestio

<img src="pleroma.png" style='width: 100%;'/>
<br/>
<br/>

# Once deployed ...

You can open Pleroma UI here:

    URL: https://[CI_CD_DOMAIN]
    login: admin
    password: [ADMIN_PASSWORD]

You can open pgAdmin web UI here:

    URL: https://[CI_CD_DOMAIN]:49371
    email: [ADMIN_EMAIL]
    password: [ADMIN_PASSWORD]

# Custom domain instructions (IMPORTANT)

By default we setup a CNAME on elestio.app domain, but probably you will want to have your own domain.

**_Step1:_** add your domain in Elestio dashboard as explained here:

    https://docs.elest.io/books/security/page/custom-domain-and-automated-encryption-ssltls

**_Step2:_** update the env vars to indicate your custom domain
Open Elestio dashboard > Service overview > click on UPDATE CONFIG button > Env tab
there update `DOMAIN` with your real domain

**_Step3:_** you must set your custom domain in `/opt/app/config.exs` (you can do that with File editor of VSCode in our tools tab)

**_Step4:_** you must reset the Pleroma instance DB, you can do that with those commands, connect over SSH and run this:

    cd /opt/app;
    docker-compose down;
    rm -rf ./storage;
    docker-compose up -d;

You will start over with a fresh instance of Pleroma directly configured with the correct custom domain name and federation will work as expected

# Federation

You can find users from other instances in two different ways:

Click on the magnifying glass to show the search bar, then you can search like that:

- @`<user>`@`<domain_of_instance>`
- https://`<domain_of_instance>`/users/`<user>`
