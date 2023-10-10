#! /usr/bin/env sh

# Minimal install of X and Chromium and connectivity.

# Not set -x because otherwise it prints out the contents of LOG_OUT as well, and so the output XML is invalid again...
set -e

apt-get update --assume-yes

sudo apt-get install --assume-yes xserver-xorg xinit x11-xserver-utils
#These are leftovers from os2borgerpc, not sure we need line 2, and line 1 is replaced with above
#apt-get install --assume-yes xinit xserver-xorg x11-xserver-utils --no-install-recommends --no-install-suggests
#apt-get install --assume-yes xdg-utils xserver-xorg-video-qxl xserver-xorg-video-all xserver-xorg-input-all libleveldb-dev


printf '%s\n' "The following output from chromium install is base64 encoded. Why?:" \
              "Chromium-install writes 'scroll'-comments to keep progress to a single line instead of taking up the entire screen," \
              "and this currently results in invalid XML, when the answer is sent back to the server"
printf '\n'

# Chromium is only available as a snap and will also be installed as
# a snap when using apt-get install
LOG_OUTPUT=$(apt-get install --assume-yes chromium-browser)
# Save exit status so we get the exit status of apt rather than from base64
EXIT_STATUS=$?
echo "$LOG_OUTPUT" | base64

CHROMIUM_POLICY_FILE="/var/snap/chromium/current/policies/managed/os2borgerpc-defaults.json"
mkdir --parents "$(dirname "$CHROMIUM_POLICY_FILE")"
cat << EOF > $CHROMIUM_POLICY_FILE
{
  "AutofillAddressEnabled": false,
  "AutofillCreditCardEnabled": false,
  "AutoplayAllowed": true,
  "PasswordManagerEnabled": false,
  "TranslateEnabled": false
}
EOF


exit $EXIT_STATUS
