#!/usr/bin/env bash
set -e

font_url() {
  echo "https://fontlibrary.org/assets/downloads/$1/$2/$1.zip"
}

install_font() {
  local name="$1"
  local hash="$2"
  local url="$3"
  mkdir -p "/usr/share/fonts/truetype/${name}"
  if [ "$url" = "fontlibrary" ]; then
    url="$(font_url "$name" "$hash")"
  fi
  local font_file="/tmp/${name}.zip"
  wget -q -O "$font_file" "$url"
  [ "$(md5sum "$font_file" | cut -d' ' -f1)" = "$hash" ] || (echo "Failed to download $name" && exit 1)
  unzip -q -o "$font_file" -d "/usr/share/fonts/truetype/${name}/"
  echo "Installed $name font."
}

install_font xb-zar       8e08f1d30a07e687d0a858558a852ce1 fontlibrary
install_font yas          6d496aade0637f6ff0aed373a19aa54a fontlibrary
install_font IranNastaliq 5ed04d7527d67ac1c002dedfbae721a4 https://cdn.irannastaliq.ir/2022/05/IranNastaliq-V2.zip

fc-cache -fv

echo "Verifying installed fonts"
fc-list | grep ": XB Zar:" || (echo "XB Zar font is missing" && exit 1)
fc-list | grep ": Yas:" || (echo "Yas font is missing" && exit 1)
fc-list | grep ": IranNastaliq:" || (echo "IranNastaliq font is missing" && exit 1)
