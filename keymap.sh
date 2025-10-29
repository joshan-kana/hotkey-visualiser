#/usr/bin/env sh

# parse keymap: only run if .yaml does not exist
# keymap parse -q ./keychron_q12_keymap.json > ./keychron_q12_keymap.yaml
# keymap parse -q ./zsa_voyager_keymap.json > ./zsa_voyager_keymap.yaml

# draw keymap
keymap draw -k keychron/q12/ansi_encoder ./keychron_q12_keymap.yaml > keychron_q12_keymap.svg
keymap draw -k zsa/voyager ./zsa_voyager_keymap.yaml > zsa_voyager_keymap.svg

# visual keymap created!
echo "Visual keymap created! ⌨️"