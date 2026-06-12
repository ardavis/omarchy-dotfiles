{
  "hook_secret": "op://tmoi2qf2jmo7franvmgzdjcl24/Zillacore ZoHo Server client/hook secret",
  "default_discord_channel_id": "1488942557047165130",
  "notify_as": "threepio",
  "rules": [
    {
      "label": "Support Email",
      "enabled": true,
      "to_contains": "support@stowzilla.com",
      "subject_contains": "",
      "body_contains": "",
      "exclude_words": [],
      "emoji": "🆘",
      "discord_channel_id": null,
      "notify_as": null
    },
    {
      "label": "Privacy Inquiry",
      "enabled": true,
      "to_contains": "privacy@stowzilla.com",
      "subject_contains": "",
      "body_contains": "",
      "exclude_words": [],
      "emoji": "🔒",
      "discord_channel_id": null,
      "notify_as": null
    },
    {
      "label": "Legal",
      "enabled": true,
      "to_contains": "legal@stowzilla.com",
      "subject_contains": "",
      "body_contains": "",
      "exclude_words": [],
      "emoji": "⚖️",
      "discord_channel_id": null,
      "notify_as": null
    },
    {
      "label": "Item Sold",
      "enabled": true,
      "subject_contains": "sold",
      "emoji": "💰"
    },
    {
      "label": "Tabletop Deal Scout",
      "enabled": true,
      "subject_contains": "Tabletop Deal Scout",
      "emoji": "🎲",
      "show_body": true,
      "discord_channel_id": null,
      "notify_as": null
    }
  ],
  "fallback": {
    "enabled": true,
    "label": "Unmatched Email",
    "emoji": "📬",
    "exclude_words": [
      "fizzy"
    ]
  },
  "api": {
    "client_id": "op://tmoi2qf2jmo7franvmgzdjcl24/Zillacore ZoHo Server client/client id",
    "client_secret": "op://tmoi2qf2jmo7franvmgzdjcl24/Zillacore ZoHo Server client/client secret",
    "refresh_token": "op://tmoi2qf2jmo7franvmgzdjcl24/Zillacore ZoHo Server client/refresh token",
    "account_id": "op://tmoi2qf2jmo7franvmgzdjcl24/Zillacore ZoHo Server client/account id"
  }
}