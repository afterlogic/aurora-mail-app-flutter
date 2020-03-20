
./sh/build_variant.sh $1/afterlogic/build_variant.yaml
./sh/build_apk.sh
./sh/build_appbundle.sh

./sh/build_variant.sh $1/private_mail/build_variant.yaml
./sh/build_apk.sh
./sh/build_appbundle.sh