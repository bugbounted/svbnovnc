 FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y
RUN apt-get install -y wget
RUN apt-get install -y unrar
RUN apt-get install -y wine
RUN apt-get install -y xvfb
RUN apt-get install -y git
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y supervisor
RUN apt-get install -y x11vnc

RUN pip3 install websockify 
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC 
RUN ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html 
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
    
# Download SilverBullet v1.1.2 software 
RUN wget https://github.com/mohamm4dx/SilverBullet/releases/download/1.1.2/SilverBullet.v1.1.2.rar 
RUN unrar x SilverBullet.v1.1.2.rar 
RUN rm SilverBullet.v1.1.2.rar 

 # Install SilverBullet v1.1.2 software using wine 
 RUN wine SilverBullet_Setup_v112_x86_64bit_enUS_Installer /S /D=C:\SilverBullet

 # Expose SilverBullet on web using noVNC 
 ENV DISPLAY :0 

 CMD ["xvfb-run", "--server-args='-screen 0 1024x768x24'", "noVNC"]
