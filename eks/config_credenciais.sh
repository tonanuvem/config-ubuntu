echo "Cole suas credenciais da AWS, e digite ENTER (2 vezes):"
CRED=$(sed '/^$/q')

#read -d '' x <<EOF
echo "$CRED" > ./files/credentials
