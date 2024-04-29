#!/bin/bash
#-adsh_path_var FILE_PATH

source ./.env

subdomains=(
    "${SUBDOMAIN_WEB}"
    "${SUBDOMAIN_API}"
    "${SUBDOMAIN_ADMIN}"
)

input=$1

FILE_PATH=/etc/hosts
if [ $input ]; then
    FILE_PATH=$input
fi

echo "\nAppending project hosts for local env to the file: ${FILE_PATH}\n"

echo "# ----- ${APP_DOMAIN} start -----"
echo "# ----- ${APP_DOMAIN} start -----" >> ${FILE_PATH}

echo "127.0.0.1    ${APP_DOMAIN}"
echo "127.0.0.1    ${APP_DOMAIN}" >> ${FILE_PATH}

for subdomain in ${subdomains[@]}
do
    if [ $subdomain ]; then
        echo "127.0.0.1    ${subdomain}.${APP_DOMAIN}"
        echo "127.0.0.1    ${subdomain}.${APP_DOMAIN}" >> ${FILE_PATH}
    fi
done

echo "# ----- ${APP_DOMAIN} end -----"
echo "# ----- ${APP_DOMAIN} end -----" >> ${FILE_PATH}

echo "" >> ${FILE_PATH}
