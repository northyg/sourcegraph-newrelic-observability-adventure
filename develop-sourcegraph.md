### Developer environment for Sourcegraph


[Follow the steps here.](https://docs.sourcegraph.com/dev/setup/quickstart)

The terminal walk through is actually really good! If you are not a Sourcegraph employee, run with `sg start oss`


The following has been a road block _everytime_. If you're getting a yarn or go version that's incorrect in the `sg setup` part, it might actually be this:

<img width="1109" alt="image" src="https://user-images.githubusercontent.com/27694443/160951892-3ae7c5a4-3e58-4085-b58d-13deeff4c2eb.png">

To fix, in the terminal:

$ `source ~/.nvm/nvm.sh`

$ `nvm alias default 16.7.0`

Then try starting Sourcegraph and see if it works!

`sg start oss`

If it works, make a new branch to play with:

$ `git branch YOUR_BRANCH_NAME`

$ `git checkout YOUR_BRANCH_NAME`

If you see this then you know you're good to go!

<img width="623" alt="image" src="https://user-images.githubusercontent.com/27694443/160952321-fad4edfd-2e00-4d51-b32a-8dc3832612a8.png">

Next, open a new terminal tab or window to navigate the code, make changes and it will automagically update in your current Sourcegraph :)

I use VSC extension to easily open the code section I want in VSC

`code .` in the directory or specify the file name

