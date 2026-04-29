function ssh-keypair
    set name $argv[1]

    # Generate a random password
    set password (openssl rand -base64 12)

    # Generate RSA key with the random password as passphrase
    openssl genrsa 2048 | openssl pkcs8 -topk8 -v2 des3 -inform PEM -out "$name.p8" -passout pass:"$password"

    # Generate Public Key from RSA key
    openssl rsa -in "$name.p8" -pubout -out "$name.key" -passin pass:"$password"

    set truncated_pubkey (cat "$name.key" | sed -e '1d' -e '$d' | tr -d '\n')

    printf "Private Key: %s\n" (cat "$name.p8" | base64)
    printf "\nPublic Key: %s\n" $truncated_pubkey
    printf "\nPassphrase: %s\n" $password
    rm "$name.p8" "$name.key"
end
