module "dns-records" {
  source = "./modules/cloudflare-dns-record"

  config = {
    root-domain-name = local.domain-name
    dns-record = {
      name    = local.sub-domain-name
      proxied = true
      value   = module.load-balancer.load-balancer-dns
    }
  }
}

resource "cloudflare_record" "certificate" {
  count = length(module.certificate.domain-validation-options)

  name     = trim(module.certificate.domain-validation-options[count.index].triggers.name, ".")
  priority = try(module.certificate.domain-validation-options[count.index].triggers.priority, null)
  proxied  = try(module.certificate.domain-validation-options[count.index].triggers.proxied, false)
  type     = try(module.certificate.domain-validation-options[count.index].triggers.type, "CNAME")
  value    = trim(module.certificate.domain-validation-options[count.index].triggers.record, ".")
  zone_id  = data.cloudflare_zone.zone.id

  depends_on = [
    module.certificate
  ]
}
