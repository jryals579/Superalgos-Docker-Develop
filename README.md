# SUPERALGOS Node based Crypto Trading Bot
Setup to Develop Superalgos in a Docker Container

DEVELOPMENT ENVIROMENT with a Docker Container

https://github.com/Superalgos/Superalgos

This is a Docker Image with Linux Apline, Node.js, Git and Python3. Once the Image is launched as a container you can mount a local folder "app" to it. The Container will then download the latest Superalgos Develop version into that mounted folder.

The Dockerfiles are from here https://github.com/mARTin-B78/Superalgos-Docker-Develop

## Preparation - Github Account / Fork Superalgos / Personal Access Token

First you need a GitHub Account https://github.com/join
IMPORTANT! Your GitHub Username will become your Superalgos Username and also your Affiliate ID! 

![001](https://user-images.githubusercontent.com/91568406/141653138-ebf01715-428d-4a14-a223-b99c1f2b6dc9.PNG)
Login to your GitHub Account https://github.com/login



Now you need to create a Github Personal Access Token

![002](https://user-images.githubusercontent.com/91568406/141653139-0b85b95b-8432-41eb-bcd2-df39cf850645.PNG)
Click on Your user Icon at the top right and select "Settings" from the dropdown menu.

![003](https://user-images.githubusercontent.com/91568406/141653140-6ffd23cf-7d5f-426e-acdc-6a7a56dc30fe.PNG)
Click on Developer Settings

![004](https://user-images.githubusercontent.com/91568406/141653141-bb0f5b1d-69a6-4355-bae3-10a328eee3d5.PNG)
Click on Personal Access tokens

![005](https://user-images.githubusercontent.com/91568406/141653142-16f4a2e6-fa50-4094-a13d-cf136894840d.PNG)
Click on Generate new token

![006](https://user-images.githubusercontent.com/91568406/141653143-d1877bf3-6d32-425b-a928-d150ac8d8f6b.PNG)
Type in a Name for your Token like "Superalgos"
Set the Expiration Time, I picked "no expiration"
Check the Box at "repo" and "workflow" 
and scroll down to the bottom 

![007](https://user-images.githubusercontent.com/91568406/141653144-b2974fab-98b7-484c-931e-0681eb9b509c.PNG)
Click on Generate token

![008](https://user-images.githubusercontent.com/91568406/141653145-19bcee1e-e217-4e95-b92f-7ad5a341983f.PNG)
Copy your token and your GitHub Username and Save it somewhere save for later.

## Installation

I assume you have a System where Docker is already installed and running. A Synology NAS in my case.
Launch Docker

![010b](https://user-images.githubusercontent.com/91568406/141654351-7c64e405-a6e5-4945-9e3f-6ded5af75231.PNG)
Click on "Registry" search for "Superalgos" and download "martinb78/superalgos-docker-develop

![010](https://user-images.githubusercontent.com/91568406/141653146-0f879595-9b3f-44a3-b0af-11a632451f12.PNG)
Click on "Image" and once the Image finished downloading click on it and click on "launch" 

![011](https://user-images.githubusercontent.com/91568406/141653147-8eceb0e1-2467-4afe-a637-c656c246a0f4.PNG)
In the General Settings click on "Advanced Settings"

![012](https://user-images.githubusercontent.com/91568406/141653148-c82e72a6-feaf-4018-84d9-27fbd02d7517.PNG)
At "Volume" click on "Add Folder", pick a folder on Your System where you want the Superalgos files to be stored and add the Mount path "/app"

![013](https://user-images.githubusercontent.com/91568406/141653149-e38b51bb-2aaf-4039-9825-458449c8534a.PNG)
At Port Settings change the lokal Ports to 18041 and 34248 or your liking or leave it on Auto.

![014](https://user-images.githubusercontent.com/91568406/141653150-76af02d3-d759-4fef-b363-980786dcfdbf.PNG)
The "default" Ports are 18041 and 34248 - if your run more than one Superalgo Bots on your system you need to change them.

![015](https://user-images.githubusercontent.com/91568406/141653151-47615e5d-28d3-43e6-8b2e-3f2d92ee5bd7.PNG)
Click on the "Enviroment" tab and 
- Paste in your GitHub Username
- Paste in your GitHub Personal Access Torken
- and Paste in your Github Username inbetween the Github Repository_URL 
(you need to "Fork Superalgos/Superalgos for this to work)

![016](https://user-images.githubusercontent.com/91568406/141653153-8e9ad899-7f55-4012-94d1-56ae002160da.PNG)

![017](https://user-images.githubusercontent.com/91568406/141653154-b4c03603-4768-4c3c-b2c1-6137355e448b.PNG)
![018](https://user-images.githubusercontent.com/91568406/141653155-660d544a-1c6d-4fda-99f3-12d0cfc2ddc7.PNG)
![019](https://user-images.githubusercontent.com/91568406/141653156-219c1bc0-823f-4760-b058-6cf49331db50.PNG)
![020](https://user-images.githubusercontent.com/91568406/141653157-4cf3071b-b0c4-4117-a716-b32ffe8ad99a.PNG)
![021](https://user-images.githubusercontent.com/91568406/141653158-613384c6-ef52-42dd-9c2d-c08dead55093.PNG)
![022](https://user-images.githubusercontent.com/91568406/141653160-1b941d91-5cfb-4f0e-a36a-3b55d87f2e38.PNG)
![023](https://user-images.githubusercontent.com/91568406/141653162-5c7485f0-a1ca-4ace-9855-d5e6c4e49d5d.PNG)
![024](https://user-images.githubusercontent.com/91568406/141653163-43d601f6-5012-4886-8c2b-9132374cab8e.PNG)
![025](https://user-images.githubusercontent.com/91568406/141653164-1f823ca1-3f21-4aeb-b759-0e818ccc1d67.PNG)
![026](https://user-images.githubusercontent.com/91568406/141653165-063d774c-9661-4e5f-b490-765235ac7717.PNG)
![027](https://user-images.githubusercontent.com/91568406/141653167-8feca04e-26cb-4ffd-be77-fb47eac7d369.PNG)
![028](https://user-images.githubusercontent.com/91568406/141653168-8d0d2ca1-8476-4359-814a-7708ad866756.PNG)
![029](https://user-images.githubusercontent.com/91568406/141653127-6ea51907-6f1d-4762-a54d-6fb9f65ded2c.PNG)
![030](https://user-images.githubusercontent.com/91568406/141653129-5e76a7c0-dda5-49b5-a4f9-fd73d6bd7bf2.PNG)
![031](https://user-images.githubusercontent.com/91568406/141653130-5903a27f-cd06-494f-a32c-1b3843d4dd20.PNG)
![032](https://user-images.githubusercontent.com/91568406/141653131-934985c6-6c7f-420d-90c7-af24c3060d15.PNG)
![033](https://user-images.githubusercontent.com/91568406/141653132-775f4346-b873-47ce-9380-3a939b125e77.PNG)
![034](https://user-images.githubusercontent.com/91568406/141653133-c59714aa-0212-4934-a24c-985951fcca0e.PNG)
![035](https://user-images.githubusercontent.com/91568406/141653134-34b14f9b-7340-41dc-8d5e-21aa15ab5e8f.PNG)
![036](https://user-images.githubusercontent.com/91568406/141653135-3cc55079-0423-4a47-a34d-d027fe38c662.PNG)
![037](https://user-images.githubusercontent.com/91568406/141653137-49c5ba80-047b-4a4b-9208-4742cf6d5672.PNG)

