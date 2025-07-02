resource "aws_route53_record" "tfer--Z0166393VM2K770ORL4S__5b237cbb62f255a90e62a7b54faa6819-002E-dumperjumper-002E-com-002E-_CNAME_" {
  multivalue_answer_routing_policy = "false"
  name                             = "_5b237cbb62f255a90e62a7b54faa6819.dumperjumper.com"
  records                          = ["_d0fabd8b938a58e8653904a5c2b4804c.xlfgrmvvlj.acm-validations.aws."]
  ttl                              = "300"
  type                             = "CNAME"
  zone_id                          = "${aws_route53_zone.tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = "d2tl6b6hnif6ap.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }

  multivalue_answer_routing_policy = "false"
  name                             = "dumperjumper.com"
  type                             = "A"
  zone_id                          = "${aws_route53_zone.tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com-002E-_NS_" {
  multivalue_answer_routing_policy = "false"
  name                             = "dumperjumper.com"
  records                          = ["ns-1408.awsdns-48.org.", "ns-1651.awsdns-14.co.uk.", "ns-325.awsdns-40.com.", "ns-981.awsdns-58.net."]
  ttl                              = "172800"
  type                             = "NS"
  zone_id                          = "${aws_route53_zone.tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com-002E-_SOA_" {
  multivalue_answer_routing_policy = "false"
  name                             = "dumperjumper.com"
  records                          = ["ns-1651.awsdns-14.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl                              = "900"
  type                             = "SOA"
  zone_id                          = "${aws_route53_zone.tfer--Z0166393VM2K770ORL4S_dumperjumper-002E-com.zone_id}"
}
