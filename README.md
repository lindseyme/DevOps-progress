# Deploying my Simulations Checkpoint
Deploying my simulations checkpoint  as an EC2 instance instance

## About the project
The simulations project was written in react/redux. The application is about a writing platform called AUTHORS HAVEN where different people express themselves through writing and also get an aundience for the written articles.

The script has been tested on AWS EC2 instance (ubuntu 18.04)

### Steps taken
- Clone the repository https://github.com/lindseyme/DevOps-progress.git
- Git branch checkout branch output-2.1.
- The script is called `server.sh`.
- Create an EC2 instance on AWS for the project.
- Copy the script to the EC2 instance.
- SSH into the server.
- Change the mode of the bash script to be executable.
- Run the bash script.

#### This is what is done when the bash script is running
- Get update and install the required packages ie nginx, nodejs and yarn.
- Clone the repository https://github.com/andela/ah-frontend-zeus.git.
- Change directory to where the cloned repository is.
- Install the required dependencies for the project to run.
- Start the application using command.
- Configure nginx.
- Use certbot for SSL certification.
