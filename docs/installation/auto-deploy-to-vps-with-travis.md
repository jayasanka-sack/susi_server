- Create a new ssh key by running:

 ```
   ssh-keygen -t rsa -b 4096 -C 'build@travis-ci.org' -f deploy_rsa
  ```
 
- Confirm that you have two files: `deploy_rsa` and `deploy_rsa.pub` after running the above command.

- Once an SSH key has been created, the ssh-copy-id command can be used to install it as an authorized key on the server.
```
ssh-copy-id -i deploy_rsa.pub user@host
```

- But we should not commit the created public key to our repo. We need to encrypt the key using Travis. This will update the `deploy_rsa.enc` file and also it will add respective environment variables on your repository’s Travis build settings.

 ```
   travis encrypt-file deploy_rsa
  ```

- Login to your server using the terminal. Clone the repository from your fork.

  ```
    git clone https://github.com/<github_username>/susi_server.git
   ```

- Login to the Travis dashboard and navigate to your repository. Add the following environment variables to the Travis build.

USER_NAME - Github username.

IP - ip address of your server.

- Now Travis will automatically deploy the latest version whenever it receives a change to your fork. You can access the Susi server on port `4000` on your server.


