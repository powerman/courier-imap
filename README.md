# Courier-IMAP APT repository

## Setup

```
sudo apt-get install wget lsb-release gnupg
wget -q -O - http://powerman.github.io/courier-imap/public.key | gpg --dearmor | sudo tee /etc/apt/keyrings/courier-imap.gpg >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/courier-imap.gpg] https://powerman.github.io/courier-imap/apt/$(lsb_release -cs) $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/courier-imap.list
apt-get update
```

## Install

### Courier Authentication Library (authdaemond, libs and optional modules)

```
apt-get install libcourier-auth \
    libcourier-auth-ldap        \
    libcourier-auth-mysql       \
    libcourier-auth-pgsql       \
    libcourier-auth-pipe        \
    libcourier-auth-sqlite      \
    libcourier-auth-userdb 
```

### Courier-IMAP

```
apt-get install courier-imap
```

## Package list

- Ubuntu 22.04 jammy
  - courier-imap 5.2.1
  - courier-authlib 0.72.0
  - courier-unicode 2.2.6
