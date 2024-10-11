{ lib, pkgs, ... }:
let
  domjudge_url = "dj.chipcie.ch.tudelft.nl";
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    profiles = {
      default = {
        extensions = [ ];

        bookmarks = [
          {
            name = "Sites";
            toolbar = true;
            bookmarks =
              [
                {
                  name = "DOMjudge";
                  url = "http://${domjudge_url}";
                  # "Favicon" = "http://${domjudge_url}/favicon.ico";
                }
                {
                  name = "DOMjudge team manual";
                  url = "http://${domjudge_url }/doc/manual/domjudge-team-manual.pdf";
                  # "Favicon" = "http://${domjudge_url}/favicon.ico";
                }
                {
                  name = "Jury Advice";
                  url = "http://localhost/jury-advice/jury-advice.pdf";
                }
                {
                  name = "Documentation";
                  url = "http://localhost";
                }
              ];
          }
        ];
        settings = {
          "browser.startup.homepage" = "${domjudge_url}|${domjudge_url}/doc/manual/domjudge-team-manual.pdf|localhost";
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "app.update.enabled" = false;
          "browser.rights.3.shown" = true;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "browser.newtabpage.enabled" = false;
          "browser.urlbar.suggest.bookmark" = true;
          "browser.urlbar.suggest.history" = true;
          "browser.urlbar.suggest.openpage" = true;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.quicksuggest" = false;
          "browser.urlbar.suggest.calculator" = true;
          "datareporting.policy.firstRunURL" = "";
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "app.shield.optoutstudies.enabled" = false;

          "browser.places.smartBookmarksVersion" = -1;
          "browser.bookmarks.restore_default_bookmarks" = false;

          "browser.toolbars.bookmarks.visibility" = "always";

          "network.captive-portal-service.enabled" = false;

          "xpinstall.signatures.required" = false;
          "extensions.installDistroAddons" = true;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
    policies = {
      # NoDefaultBookmarks = true;
      # DisableProfileImport = true;
      ExtensionSettings = lib.mkForce {
        "dj-addon@chipcie.ch.tudelft.nl" = {
          "installation_mode" = "force_installed";
          "install_url" = "file:///icpc/dj-addon@chipcie.ch.tudelft.nl.xpi";
        };
      };
    };
  };
}
