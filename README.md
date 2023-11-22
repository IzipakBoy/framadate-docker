# Project overview

Contenairized [Framadate](framadate.org) webserver using the ```php:8.2.12-apache``` Docker image.

# Usage

## DB SETUP

You will need a MySQL database. Use the following commands for a fresh framadate installation:

```SQL
CREATE DATABASE IF NOT EXISTS `framadate` DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
CREATE USER 'framadate'@'%' IDENTIFIED BY 'framapass';
GRANT ALL PRIVILEGES ON `framadate`.* TO 'framadate'@'%';
```

## ENVIRONMENT VARIABLES
 
The container reads the following environment variables at runtime :

**APP_URL** : domain name for the framadate application  
**APP_ADMIN_PASSWORD** : password for the framadate admin interface  
**DB_ADDRESS** : address of the framadate database  
**DB_PASSWORD** : password of the database *framadate* user

## INITIALIZE FRAMADATE

First of all, clone this repository and ```cd``` into the created folder.  
Make sure the environment variables of the previous section are readable by the container at runtime. It can be done by adding instructions like the following at the end of the ```Dockerfile``` file, right before ```ENTRYPOINT```:  
```Dockerfile
ENV VAR=VALUE
```
For example:
```Dockerfile
ENV APP_URL=framadate.mywebsite.com
```

Then build the container image and run it with ```/tmp/entrypoint_init.sh``` as entrypoint :  
```bash
sudo docker image build -t framadate .  
sudo docker run -p 80:80 --name framadate-container --entrypoint "/tmp/entrypoint_init.sh" framadate  
```
The web interface of framadate should now be accessible. Access it and follow the instructions to populate your database. Once it is done, stop the container.

## FRAMADATE CONFIGURATION

### General configuration

Modify ```config/config.php``` according to your needs.

### SSL configuration

See the [framadate wiki.](https://framagit.org/framasoft/framadate/framadate/-/wikis/install/Configure#https) Write your changes to the Apache configuration into ```config/000-default.conf```.

### SMTP configuration

SMTP is disabled by default. See ```config/config.php``` to use and configure a SMTP connection.  

### Framadate banner image

Change ```resources/banner.png``` for a custom framadate banner.

### Rebuilding the container image

Once you're done with your configuration, rebuild the image like so:  
```bash
sudo docker image build -t framadate .  
```

## GENERAL USAGE

### Running the container

```bash
sudo docker run -p 80:80 --name framadate-container framadate
```

### Administration

The framadate admin web interface is accessible at **APP_URL**/admin with **APP_ADMIN_PASSWORD** as password.