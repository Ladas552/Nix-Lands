{
  hosts = [ "laptop" ];
  config = {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "edge";
        disableWhileTyping = false;
        clickMethod = "buttonareas";
      };
      mouse = {
        middleEmulation = false;
      };
    };
  };
}
