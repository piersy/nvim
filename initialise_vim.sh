#!/bin/bash
# This runs vim and causes plug to install plugins and then exit after 15
# seconds. This is required since starting vim without plugins installed
# somehow screws with the key mappings and you cannot control vim and can no
# longer exit vim.
vim -c "PlugInstall | sleep 15 | qa!"
