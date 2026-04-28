FROM kasmweb/desktop:1.15.0

USER root

RUN apt update && apt install -y \
    wget \
    unzip \
    libxcursor1 \
    libxinerama1 \
    libxrandr2 \
    libxi6 \
    libgl1 \
    libxkbcommon0

RUN wget https://github.com/godotengine/godot/releases/download/4.5-stable/Godot_v4.5-stable_linux.x86_64.zip \
    && unzip Godot_v4.5-stable_linux.x86_64.zip \
    && mv Godot_v4.5-stable_linux.x86_64 /usr/local/bin/godot \
    && chmod +x /usr/local/bin/godot

# Create XFCE autostart
# RUN mkdir -p /home/kasm-user/.config/autostart \
#     && echo '[Desktop Entry]\
# Type=Application\
# Exec=godot\
# Hidden=false\
# NoDisplay=false\
# X-GNOME-Autostart-enabled=true\
# Name=Godot\
# Comment=Start Godot editor\
#     ' > /home/kasm-user/.config/autostart/godot.desktop \
#     && chown -R 1000:0 /home/kasm-user/.config

# COPY startup.sh /startup.sh
# RUN chmod +x /startup.sh

# RUN echo '#!/bin/bash\n\
# sleep 5\n\
# godot &\n\
# ' > /dockerstartup/custom_startup.sh \
#  && chmod +x /dockerstartup/custom_startup.sh

# RUN mkdir -p /dockerstartup/startup \
#  && echo '#!/bin/bash\
# sleep 5\
# godot &' > /dockerstartup/startup/godot.sh \
#  && chmod +x /dockerstartup/startup/godot.sh

# RUN sed -i 's/enable: true/enable: false/g' /etc/kasmvnc/kasmvnc.yaml

RUN echo '#!/bin/bash\n\
echo "Launching Godot..."\n\
sleep 6\n\
godot -f --resolution 1280x720 --path /home/kasm-user/workspace/camera-stream-test\n\
tail -f /dev/null\
' > /dockerstartup/custom_startup.sh \
 && chmod +x /dockerstartup/custom_startup.sh

USER 1000