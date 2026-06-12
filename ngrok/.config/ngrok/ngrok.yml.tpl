version: "3"
agent:
    authtoken: {{ op://tmoi2qf2jmo7franvmgzdjcl24/Ngrok/authtoken }}

tunnels:
    zillacore:
        proto: http
        addr: 4567
        # No static domain - will get random URL
    
    posh_nosh:
        proto: http
        addr: 3002
        domain: {{ op://tmoi2qf2jmo7franvmgzdjcl24/Ngrok/static url }}
