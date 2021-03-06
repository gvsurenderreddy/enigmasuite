#<pre>
node 'box' {

    class {"cjdns":
        ipv6 => "{{ box.ipv6 }}",
        public_key => "{{ box.public_key }}",
        private_key => "{{ box.private_key }}",
        autopeering => "{{ autopeering }}",
{% if allow_peering == '1' and peering_port and peering_password %}
        peering_port => "{{ peering_port }}",
        peering_password => "{{ peering_password }}",
{% endif %}

        connect_to => [
{% if peerings %}{% for peering in peerings %}
            {
                address => "{{ peering.address }}",
                password => "{{ peering.password }}",
                public_key => "{{ peering.public_key }}",
            },
{% endfor %}{% endif %}
        ],

        outgoing_connections => [
{% if internet_gateway %}
            "{{ internet_gateway.public_key }}",
{% endif %}
        ],

        puppetmasters => [
{% if puppetmasters %}{% for pm in puppetmasters %}
            "{{ pm.ip }}",
{% endfor %}{% endif %}
        ],

        wlan_ssid => "{{ wlan_ssid }}",
        wlan_pass => "{{ wlan_pass }}",
        wlan_security => "{{ wlan_security }}",
        wlan_group => "{{ wlan_group }}",
        wlan_pairwise => "{{ wlan_pairwise }}",
        network_preference => "{{ network_preference }}",
    }

    class {"box-networking":
        addresses => [
{% if addresses %}{% for address in addresses %}
            {
                name => "{{ address.name }}",
                display_name => "{{ address.display_name }}",
                ipv6 => "{{ address.ipv6 }}",
            },
{% endfor %}{% endif %}
        ],

        puppetmasters => [
{% if puppetmasters %}{% for pm in puppetmasters %}
            {
                ip => "{{ pm.ip }}",
                hostname => "{{ pm.hostname }}",
            },
{% endfor %}{% endif %}
        ],

{% if allow_peering == '1' and peering_port %}
        peering_port => "{{ peering_port }}",
{% endif %}

        teletext_enabled => "{{ teletext_enabled }}",
        display_expiration_notice => "{{ display_expiration_notice }}",
        global_availability => "{{ global_availability }}",
    }

    class {"asterisk":
        addresses => [
{% if addresses %}{% for address in addresses %}{% if address.phone %}
            {
                name => "{{ address.name }}",
                display_name => "{{ address.display_name }}",
                ipv6 => "{{ address.ipv6 }}",
                phone => "{{ address.phone }}",
            },
{% endif %}{% endfor %}{% endif %}
        ],
        global_addresses => [
{% if global_addresses %}{% for address in global_addresses %}{% if address.phone %}
            {
                ipv6 => "{{ address.ipv6 }}",
                hostname => "{{ address.hostname }}",
                phone => "{{ address.phone }}",
            },
{% endif %}{% endfor %}{% endif %}
        ],
    }

    class {"email":
        ipv6 => "{{ box.ipv6 }}",
        addresses => [
{% if addresses %}{% for address in addresses %}{% if address.phone %}
            {
                name => "{{ address.name }}",
                ipv6 => "{{ address.ipv6 }}",
            },
{% endif %}{% endfor %}{% endif %}
        ],
        mailbox_password => "{{ mailbox_password }}",
    }

    class {"security":
        webinterface_password => "{{ webinterface_password }}",
        hostid => "{{ hostid }}",
    }

    class {"privoxy":
        filter_ads => "{{ webfilter_filter_ads }}",
        block_facebook => "{{ webfilter_block_facebook }}",
        block_google => "{{ webfilter_block_google }}",
        block_twitter => "{{ webfilter_block_twitter }}",
        custom_rules => "{{ webfilter_custom_rules }}",
        custom_rules_text => "{{ webfilter_custom_rules_text }}",
    }

    class {"teletext":
        teletext_enabled => "{{ teletext_enabled }}",
    }

    class {"renew-notice":
        display_expiration_notice => "{{ display_expiration_notice }}",
    }

    class {"upgrader":
    }
}
