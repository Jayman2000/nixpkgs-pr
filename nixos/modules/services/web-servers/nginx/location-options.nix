# This file defines the options that can be used both for the Nginx
# main server configuration, and for the virtual hosts.  (The latter
# has additional options that affect the web server as a whole, like
# the user/group to run under.)

{ lib, config }:

with lib;

{
  options = {
    basicAuth = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = literalExpression ''
        {
          user = "password";
        };
      '';
      description = lib.mdDoc ''
        Basic Auth protection for a vhost.

        WARNING: This is implemented to store the password in plain text in the
        Nix store.
      '';
    };

    basicAuthFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = lib.mdDoc ''
        Basic Auth password file for a vhost.
        Can be created via: {command}`htpasswd -c <filename> <username>`.

        WARNING: The generate file contains the users' passwords in a
        non-cryptographically-securely hashed way.
      '';
    };

    proxyPass = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "http://www.example.org/";
      description = lib.mdDoc ''
        Adds proxy_pass directive and sets recommended proxy headers if
        recommendedProxySettings is enabled.
      '';
    };

    proxyWebsockets = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = lib.mdDoc ''
        Whether to support proxying websocket connections with HTTP/1.1.
      '';
    };

    index = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "index.php index.html";
      description = lib.mdDoc ''
        Adds index directive.
      '';
    };

    tryFiles = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "$uri =404";
      description = lib.mdDoc ''
        Adds try_files directive.
      '';
    };

    root = mkOption {
      type = types.nullOr types.path;
      default = null;
      example = "/your/root/directory";
      description = lib.mdDoc ''
        Root directory for requests.
      '';
    };

    alias = mkOption {
      type = types.nullOr types.path;
      default = null;
      example = "/your/alias/directory";
      description = lib.mdDoc ''
        Alias directory for requests.
      '';
    };

    return = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "301 http://example.com$request_uri";
      description = lib.mdDoc ''
        Adds a return directive, for e.g. redirections.
      '';
    };

    fastcgiParams = mkOption {
      type = types.attrsOf (types.either types.str types.path);
      default = {};
      description = lib.mdDoc ''
        FastCGI parameters to override.  Unlike in the Nginx
        configuration file, overriding only some default parameters
        won't unset the default values for other parameters.
      '';
    };

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = lib.mdDoc ''
        These lines go to the end of the location verbatim.
      '';
    };

    priority = mkOption {
      type = types.int;
      default = 1000;
      description = ''
        Order of this location block in relation to the others in the vhost.
        The semantics are the same as with `lib.mkOrder`. Smaller values have
        a greater priority.
      '';
    };

    recommendedProxySettings = mkOption {
      type = types.bool;
      default = config.services.nginx.recommendedProxySettings;
      defaultText = literalExpression "config.services.nginx.recommendedProxySettings";
      description = lib.mdDoc ''
        Enable recommended proxy settings.
      '';
    };
  };
}
