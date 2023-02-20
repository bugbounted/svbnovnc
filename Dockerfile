 FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unrar \
    wine \
    noVNC \
    xvfb 
    
# Download SilverBullet v1.1.2 software 
RUN wget https://github.com/mohamm4dx/SilverBullet/releases/download/1.1.2/SilverBullet.v1.1.2.rar 
RUN unrar x SilverBullet.v1.1.2.rar 
RUN rm SilverBullet.v1.1.2.rar 

 # Install SilverBullet v1.1.2 software using wine 
 RUN wine SilverBullet_Setup_v112_x86_64bit_enUS_Installer /S /D=C:\SilverBullet

 # Expose SilverBullet on web using noVNC 
 ENV DISPLAY :0 

 CMD ["xvfb-run", "--server-args='-screen 0 1024x768x24'", "noVNC"]
