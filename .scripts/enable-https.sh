#!/bin/bash

source ./.env

function build_domain() {
    local domain

    if [ $1 ] ; then
        domain="$1.${APP_DOMAIN}"
    else
        domain="${APP_DOMAIN}"
    fi
    echo "${domain}"
}

function check_support_os() {
    local os
    os=`uname -s`
    if [ "$os" == "Linux" ]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            if [ "$ID" == "debian" ] || [ "$ID_LIKE" == "debian" ]; then
                echo "Debian"
                # Debian系の場合の処理をここに書く
            else
                echo "UnsupportedLinuxDistro"
                # 非Debian系の場合の処理をここに書く
            fi
        else
            echo "UnsupportedLinuxDistro"
            # 非Debian系の場合の処理をここに書く
        fi
    elif [ "$os" == "Darwin" ]; then
        echo "MacOS"
    else
        echo "UnsupportedOS"
    fi
}

os=`check_support_os`
echo "os: ${os}"

if [ "$os" == "UnsupportedOS" ]; then
    echo "This OS is not supported. Please use Debian(or Ubuntu) or MacOS."
    echo "If windows, please use WSL2."
    exit 1
fi

if [ "$os" == "UnsupportedLinuxDistro" ]; then
    echo "This Linux distro is not supported. Please use Debian or Ubuntu."
    exit 1
fi

domains=(
    `build_domain ${SUBDOMAIN_WEB}`
    `build_domain ${SUBDOMAIN_API}`
    `build_domain ${SUBDOMAIN_ADMIN}`
)

domains_str=
for domain in ${domains[@]}
do
    domains_str="${domains_str} ${domain}"
done

echo ${domains_str}

# mkcertのコマンドがない場合はインストールする
if ! type "mkcert" > /dev/null 2>&1; then
    echo "Install mkcert CLI"
    if [ "$os" == "MacOS" ]; then
        HOMEBREW_NO_AUTO_UPDATE=1 brew install mkcert
    elif [ "$os" == "Debian" ]; then
        sudo apt update -y \
        && sudo apt install libnss3-tools -y \
        && curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi - \
        && mv mkcert-v*-linux-amd64 mkcert \
        && chmod a+x mkcert \
        && sudo mv mkcert /usr/local/bin/
    fi
fi

echo "Generate local CA"
mkcert -install

echo "Generate local SSL certificate"
mkcert \
    -cert-file ./.docker/local/nginx/ssl/local-cert.pem \
    -key-file ./.docker/local/nginx/ssl/local-key.pem \
    ${domains_str}


echo "Change permission"
chmod 644 ./.docker/local/nginx/ssl/local-key.pem

