#Set mid server variables
export instance='https://dev123861.service-now.com'
export midservername='my-docker-midserver'
export miduser='mid_user'
export midpassword='5m6&4^u0Nv3UFn}(V@a$@}]9!dj}3)7Pth3>ZW](ZYi#Z$FAcn)'
export dockerImage='servicenow_midserver'

#download the build files
mkdir snbuild && cd "$_"
#you can get the latest link from your instance
wget https://install.service-now.com/glide/distribution/builds/package/app-signed/mid-linux-container-recipe/2023/09/21/mid-linux-container-recipe.vancouver-07-06-2023__patch2-09-13-2023_09-21-2023_1911.linux.x86-64.zip
zipFile='mid-linux-container-recipe.vancouver-07-06-2023__patch2-09-13-2023_09-21-2023_1911.linux.x86-64.zip'
unzip .

#create the docker image
sudo docker build . --build-arg MID_SIGNATURE_VERIFICATION=false --tag $dockerImage

#creat the docker container
sudo docker run -d \
--name $midservername \
--env MID_INSTANCE_URL=$instance \
--env MID_SERVER_NAME=$midservername \
--env MID_INSTANCE_USERNAME=$miduser \
--env MID_INSTANCE_PASSWORD=$midpassword \
$dockerImage:latest

#to tail the mid server logs
sudo docker logs $midservername --follow


#if you need to to tear it down
#sudo docker rm $midservername -f
