{
  hosts = [ "laptop" "iso"];
  config =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.sbc ];
      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
      };

      # Thanks @bananad3v
      services.pipewire.extraConfig = {
        pipewire = {
          "10-defaults" = {
            "context.properties" = {
              "clock.power-of-two-quantum" = true;
              "core.daemon" = true;
              "core.name" = "pipewire-0";
              "link.max-buffers" = 16;
              "settings.check-quantum" = true;

              "default.clock.rate" = 48000;
              "default.clock.quantum" = 256;
              "default.clock.min-quantum" = 32;
              "default.clock.max-quantum" = 4096;
            };
            "stream.properties" = {
              "resample.quality" = 10;
            };
          };

          "90-disable-bell" = {
            "context.properties" = {
              "module.x11.bell" = false;
            };
          };
        };

        pipewire-pulse = {
          "10-defaults" = {
            "context.spa-libs" = {
              "audio.convert.*" = "audioconvert/libspa-audioconvert";
              "support.*" = "support/libspa-support";
            };

            "stream.properties" = {
              "resample.quality" = 10;
            };

            "pulse.properties" = {
              "server.address" = [ "unix:native" ];
            };
          };
        };
      };
      services.pipewire.wireplumber.extraConfig = {
        "10-disable-camera" = {
          "wireplumber.profiles"."main" = {
            "monitor.libcamera" = "disabled";
          };
        };
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/state/wireplumber" ];
    };
}
