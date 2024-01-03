{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.frpc;
  settingsFormat = pkgs.formats.ini { };
  configFile = if cfg.configFile != null then cfg.configFile else settingsFormat.generate "frp.ini" cfg.settings;
  isClient = (cfg.role == "client");
  isServer = (cfg.role == "server");
in
{
  options = {
    services.frpc = {
      enable = mkEnableOption (mdDoc "frp");

      package = mkPackageOptionMD pkgs "frp" { };

      role = mkOption {
        type = types.enum [ "server" "client" ];
        description = mdDoc ''
          The frp consists of `client` and `server`. The server is usually
          deployed on the machine with a public IP address, and
          the client is usually deployed on the machine
          where the Intranet service to be penetrated resides.
        '';
      };

      settings = mkOption {
        type = settingsFormat.type;
        default = { };
        description = mdDoc ''
          Frp configuration, for configuration options
          see the example of [client](https://github.com/fatedier/frp/blob/dev/conf/frpc_legacy_full.ini)
          or [server](https://github.com/fatedier/frp/blob/dev/conf/frps_legacy_full.ini) on github.
        '';
        example = literalExpression ''
          {
            common = {
              server_addr = "x.x.x.x";
              server_port = 7000;
            };
          }
        '';
      };

      configFile = mkOption {
        type = types.str;
      };
    };
  };

  config =
    let
      serviceCapability = optionals isServer [ "CAP_NET_BIND_SERVICE" ];
      executableFile = if isClient then "frpc" else "frps";
    in
    mkIf cfg.enable {
      systemd.services = {
        frp = {
          wants = optionals isClient [ "network-online.target" ];
          after = if isClient then [ "network-online.target" ] else [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          description = "A fast reverse proxy frp ${cfg.role}";
          serviceConfig = {
            Type = "simple";
            Restart = "on-failure";
            RestartSec = 15;
            ExecStart = "${cfg.package}/bin/${executableFile} -c ${configFile}";
            StateDirectoryMode = optionalString isServer "0700";
            DynamicUser = true;
            # Hardening
            UMask = optionalString isServer "0007";
            CapabilityBoundingSet = serviceCapability;
            AmbientCapabilities = serviceCapability;
            PrivateDevices = true;
            ProtectHostname = true;
            ProtectClock = true;
            ProtectKernelTunables = true;
            ProtectKernelModules = true;
            ProtectKernelLogs = true;
            ProtectControlGroups = true;
            RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ] ++ optionals isClient [ "AF_UNIX" ];
            LockPersonality = true;
            MemoryDenyWriteExecute = true;
            RestrictRealtime = true;
            RestrictSUIDSGID = true;
            PrivateMounts = true;
            SystemCallArchitectures = "native";
            SystemCallFilter = [ "@system-service" ];
          };
        };
      };
    };

  meta.maintainers = with maintainers; [ zaldnoay ];
}
