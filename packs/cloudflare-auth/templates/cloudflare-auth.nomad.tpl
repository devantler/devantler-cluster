job "cloudflare-auth" {
  datacenters = ["dc1"]
  group "cloudflare-auth" {
    network {
      mode = "bridge"
    }
    service {
      name = "cloudflare-auth"
      port = 8080
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.cloudflare-auth.entrypoints=web",
        "traefik.http.routers.cloudflare-auth.rule=Host(`cloudflare-auth`)"
      ]
      connect {
        sidecar_service {}
      }
    }
    task "cloudflare-auth" {
      driver = "docker"
      config {
        image = "akohlbecker/traefik-auth-cloudflare:2.0"
        args = [
            "--auth-domain", "https://[[ .my.domain_name ]].cloudflareaccess.com"
        ]
      }
    }
  }
}