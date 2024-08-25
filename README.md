# Raspberry

### Config
    raspi-config

### List wireless network
    sudo iwlist wlan0 scan

### Config permanent connect to wireless (Add to bottom file.
    sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

    network={
      ssid="testing"
      psk="testingPassword"
    }

### Encrypted
    sudo wpa_passphrase "testing"
    sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
    
    network={
        ssid="testing"
        #psk="testingPassword"
        psk=131e1e221f6e06e3911a2d11ff2fac9182665c004de85300f9cac208a6a80531
    }

### Unsecured networks
If the network you are connecting to does not use a password, the wpa_supplicant entry for the network will need to include the correct key_mgmt entry. e.g.

    network={
        ssid="testing"
        key_mgmt=NONE
    }

### Hidden networks
If you are using a hidden network, an extra option in the wpa_supplicant file, scan_ssid, may help connection.

    network={
        ssid="yourHiddenSSID"
        scan_ssid=1
        psk="Your_wireless_network_password"
    }
